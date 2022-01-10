class ImportContactsService
  include ActiveStorage::Blob::Analyzable

  attr_reader :import, :headers, :file_headers

  def initialize(import_id, headers)
    @import = Import.find_by_id(import_id)
    @headers = headers

    import.update(status: 1)
  end

  def execute
    file_parsed = CSV.parse(import.file.download)
    @file_headers = build_file_headers(file_parsed.shift)

    file_parsed.each do |content|
      import_contact(content)
      break if import.failed?
    end
  end

  private

  def build_file_headers(headers)
    headers.first.split(';')
  end

  def import_contact(content)
    contact = Contact.new(user_id: import.user_id)

    content.first.split(';').each_with_index do |value, index|
      header = file_headers[index]

      field = headers.key(header)
      unless field
        create_fail_log(contact, content.first, ["Invalid headers - #{header} header found but not associated"])
        break
      end

      contact[field] = value
    end
    return if import.failed?

    contact.valid? ? finish_import(contact) : create_fail_log(contact, content.first)
  end

  def finish_import(contact)
    contact.save
    import.update(status: 3)
  end

  def create_fail_log(contact, line_content, reasons=[])
    reasons += contact.errors.full_messages

    ImportFail.create(
      import_id: import.id,
      line_content: line_content,
      fail_reasons: reasons.join(';')
    )

    import.update(status: 2)
  end
end
