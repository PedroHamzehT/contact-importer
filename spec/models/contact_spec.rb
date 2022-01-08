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
end
