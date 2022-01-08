class Contact < ApplicationRecord
  belongs_to :user

  validates :name, :date_of_birth, :address, :credit_card, :franchise, :email, presence: true
  validates :email, uniqueness: true
  validate special_chars_on_name,
           date_of_birth_format,
           phone_format

  private

  def special_chars_on_name
    special_chars_regex = /[!"#$%&'()*+,-.\/:;<=>?@[\\]^_`{|}~]/

    errors.add(:name, 'Invalid name - special character') if name[special_chars_regex]
  end

  def date_of_birth_format
    date_format_regex = /^([0-9]{8}|[0-9]{4}-[0-9]{2}-[0-9]{2})$/

    errors.add(:date_of_birth, 'Invalid date_of_birth format') unless date_of_birth[date_format_regex]
  end

  def phone_format
    phone_format_regex = /^(\(\+[0-9]{2}\) [0-9]{3} [0-9]{3} [0-9]{2} [0-9]{2}|\(\+[0-9]{2}\) [0-9]{3}-[0-9]{3}-[0-9]{2}-[0-9]{2})$/

    errors.add(:phone, 'Invalid phone format') unless phone[phone_format_regex]
  end
end
