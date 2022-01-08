class Contact < ApplicationRecord
  belongs_to :user

  encrypts :credit_card

  validates :name, :date_of_birth, :address, :credit_card, :franchise, :email, presence: true

  validates :name,          format: { without: /[!"#$%&'()*+,-.\/:;<=>?@[\\]^_`{|}~]/, message: 'Invalid special character' }
  validates :date_of_birth, format: { with: /^([0-9]{8}|[0-9]{4}-[0-9]{2}-[0-9]{2})$/, message: 'Invalid format' }
  validates :phone,         format: { with: /^(\(\+[0-9]{2}\) [0-9]{3} [0-9]{3} [0-9]{2} [0-9]{2}|\(\+[0-9]{2}\) [0-9]{3}-[0-9]{3}-[0-9]{2}-[0-9]{2})$/, message: 'Invalid format' }
  validates :email,         format: { with: /^[\w-\.]+@([\w-]+\.)+[\w-]{2,3}$/, message: 'Invalid format' }

  validate email_uniqueness

  before_save :find_franchise,
              :store_last_credit_card_numbers

  private

  def find_franchise
    self.franchise = CreditCardValidations::Detector.new(credit_card).brand
  end

  def store_last_credit_card_numbers
    self.last_credit_card_numbers = credit_card.last(4)
  end

  def email_uniqueness
    errors.add(:email, 'E-mail already exists') if find_by(email: email)
  end
end
