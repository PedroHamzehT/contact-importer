FactoryBot.define do
  factory :import do
    status { 0 }
    file { Rack::Test::UploadedFile.new("#{Rails.root}/spec/csv_samples/valid_sample.csv", 'text/csv') }
    user_id { create(:user).id }
  end
end
