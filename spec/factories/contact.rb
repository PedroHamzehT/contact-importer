FactoryBot.define do
  factory :contact do
    name { 'Pedro' }
    date_of_birth  { Date.today.strftime('%F') }
    phone { '(+57) 320-432-05-09' }
    address { 'Some place, Street' }
    credit_card { '5555555555554444' }
    franchise { 'mastercard' }
    email { 'example@gmail.com' }
    user_id { create(:user).id }
  end
end
