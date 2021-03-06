class Import < ApplicationRecord
  has_many :import_fails

  FIELDS = %w[name date_of_birth phone address credit_card email].freeze

  belongs_to :user
  has_one_attached :file

  validates :file, attached: true, content_type: { in: 'text/csv', message: 'is not a CSV' }

  enum status: { on_hold: 0, processing: 1, failed: 2, terminated: 3 }
end
