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
      contact[headers.key(header)] = value
    end

    contact.valid? ? contact.save : create_fail_log(contact)
  end

  def create_fail_log(contact)
  end
end
