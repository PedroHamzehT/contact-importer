class Import < ApplicationRecord
  FIELDS = %w[name date_of_birth phone address credit_card email].freeze

  belongs_to :user
  has_one_attached :file

  enum status: { on_hold: 0, processing: 1, failed: 2, terminated: 3 }
end
