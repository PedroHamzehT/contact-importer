require 'rails_helper'

RSpec.describe ImportContactsService do
  describe '#execute' do
    subject(:execute) { described_class.new(import.id, headers).execute }

    let(:headers) do
      { name: 'name', date_of_birth: 'date_of_birth', phone: 'phone', address: 'address', credit_card: 'credit_card', email: 'email' }
    end
    let(:valid_sample) { "#{Rails.root}/spec/csv_samples/valid_sample.csv" }
    let(:invalid_sample) { "#{Rails.root}/spec/csv_samples/invalid_sample.csv" }

    context 'valid sample' do
      let(:import) { create(:import, file: Rack::Test::UploadedFile.new(valid_sample, 'text/csv')) }

      it 'must create contacts' do
        expect { execute }.to change { Contact.count }.by(5)
      end
    end

    context 'invalid sample' do
      let(:import) { create(:import, file: Rack::Test::UploadedFile.new(invalid_sample, 'text/csv')) }

      it 'must create contacts' do
        expect { execute }.to change { ImportFail.count }.by(4)
      end

      it 'must have invalid name reason' do
        execute
        expect(ImportFail.first.fail_reasons).to include('Name invalid special character')
      end

      it 'must have email already exists reason' do
        execute
        expect(ImportFail.first.fail_reasons).to include('Email already exists')
      end

      it 'must have date of birth invalid format reason' do
        execute
        expect(ImportFail.second.fail_reasons).to include('Date of birth invalid format')
      end

      it 'must have phone invalid format reason' do
        execute
        expect(ImportFail.third.fail_reasons).to include('Phone invalid format')
      end

      it 'must have email invalid format reason' do
        execute
        expect(ImportFail.last.fail_reasons).to include('Email invalid format')
      end

    end

    context 'invalid headers' do
      let(:headers) do
        { name: 'wrong_name', date_of_birth: 'date_of_birth', phone: 'phone', address: 'address', credit_card: 'credit_card', email: 'email' }
      end
      let(:import) { create(:import, file: Rack::Test::UploadedFile.new(valid_sample, 'text/csv')) }

      it 'must have no header found to field reason' do
        execute
        expect(ImportFail.last.fail_reasons).to include('Invalid headers - name header found but not associated')
      end
    end
  end
end
