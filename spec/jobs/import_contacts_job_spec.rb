require 'rails_helper'

RSpec.describe ImportContactsJob, type: :job do
  describe '#perform_later' do
    let(:import) { create(:import) }

    let(:headers) do
      { name: 'name', date_of_birth: 'date_of_birth', phone: 'phone', address: 'address', credit_card: 'credit_card', email: 'email' }
    end

    it 'must have enqueue job' do
      ActiveJob::Base.queue_adapter = :test

      expect {
        described_class.perform_later(import.id, headers)
      }.to have_enqueued_job.with(import.id, headers)
    end
  end
end
