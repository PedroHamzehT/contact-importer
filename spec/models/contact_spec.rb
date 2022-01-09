require 'rails_helper'

RSpec.describe Contact, type: :model do
  let(:contact) { Contact.new(contact_attrs) }

  context 'valid values' do
    let(:contact_attrs) { attributes_for(:contact) }

    it 'must be valid' do
      expect(contact.valid?).to be true
    end

    it 'must create a contact' do
      expect { Contact.create(contact_attrs) }.to change { Contact.count }.by(1)
    end

    context 'credit card flows' do
      let(:contact_attrs) { attributes_for(:contact, credit_card: '371449635398431', franchise: nil) }

      it 'must save last four numbers of credit card' do
        contact.save
        expect(contact.last_credit_card_numbers).to eq(contact_attrs[:credit_card].last(4))
      end
  
      it 'must recognize the franchise' do
        franchise = CreditCardValidations::Detector.new(contact.credit_card).brand

        contact.save
        expect(contact.franchise).to eq(franchise.to_s)
      end
  
      it 'must encrypts credit card' do
        contact.save
        expect(contact.credit_card_ciphertext).not_to eq(contact_attrs[:credit_card])
      end
    end
  end

  context 'missing values' do
    let(:contact_fields) { %i[name date_of_birth phone address credit_card franchise email] }
    let(:contact_attrs) { attributes_for(:contact) }

    it 'must be invalid' do
      contact_fields.each do |contact_field|
        invalid_contact_attrs = contact_attrs
        invalid_contact_attrs.delete(contact_field)

        expect(Contact.new(invalid_contact_attrs).valid?).to be false
      end
    end

    it 'must have error message' do
      contact_fields.each do |contact_field|
        invalid_contact_attrs = contact_attrs
        invalid_contact_attrs.delete(contact_field)

        contact = Contact.new(invalid_contact_attrs)
        contact.valid?
        contact_field = contact_field.to_s.gsub(/_/, ' ')
        expect(contact.errors.full_messages).to include("#{contact_field} can't be blank".capitalize)
      end
    end
  end

  context 'invalid name format' do
    let(:contact_attrs) { attributes_for(:contact, name: 'Pedr@') }

    it 'must be invalid' do
      expect(contact.valid?).to be false
    end

    it 'must have name error' do
      contact.valid?
      expect(contact.errors.full_messages).to include('Name invalid special character')
    end
  end

  context 'invalid date_of_birth format' do
    let(:contact_attrs) { attributes_for(:contact, date_of_birth: '020220109') }

    it 'must be invalid' do
      expect(contact.valid?).to be false
    end

    it 'must have date_of_birth error' do
      contact.valid?
      expect(contact.errors.full_messages).to include('Date of birth invalid format')
    end
  end

  context 'invalid phone format' do
    let(:contact_attrs) { attributes_for(:contact, phone: '(+57)320-432-05-09') }

    it 'must be invalid' do
      expect(contact.valid?).to be false
    end

    it 'must have phone error' do
      contact.valid?
      expect(contact.errors.full_messages).to include('Phone invalid format')
    end
  end

  context 'invalid email format' do
    let(:contact_attrs) { attributes_for(:contact, email: '@gmail.com') }

    it 'must be invalid' do
      expect(contact.valid?).to be false
    end

    it 'must have email error' do
      contact.valid?
      expect(contact.errors.full_messages).to include('Email invalid format')
    end
  end
end
