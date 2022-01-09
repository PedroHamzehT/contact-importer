require 'rails_helper'

RSpec.describe Contact, type: :model do
  context 'valid values' do
    let(:contact_attrs) { attributes_for(:contact) }

    it 'must be valid' do
      expect(Contact.new(contact_attrs).valid?).to be true
    end

    it 'must create a contact' do
      expect { Contact.create(contact_attrs) }.to change { Contact.count }.by(1)
    end
  end

  context 'missing values' do
    let(:contact_fields) { %i[name date_of_birth phone address credit_card franchise email] }
    let(:contact_attrs) { attributes_for(:contact) }

    it 'must be invalid' do
      contact_fields.each do |contact_field|
        invalid_contact_attrs = contact_attrs
        invalid_contact_attrs[contact_field] = nil

        expect(Contact.new(invalid_contact_attrs).valid?).to be false
      end
    end
  end
end
