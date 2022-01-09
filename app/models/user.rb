class User < ApplicationRecord
  include ActiveModel::SecurePassword

  validates :username, presence: true, uniqueness: true
  has_secure_password

  has_many :contacts
  has_many :imports
end
