class ImportContactsJob < ApplicationJob
  queue_as :default

  def perform(import_id, headers)
    ImportContactsService.new(import_id, headers).execute
  end
end
