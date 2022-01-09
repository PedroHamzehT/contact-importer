FactoryBot.define do
  factory :import_fail do
    line_data { "MyString" }
    fail_reasons { "MyString" }
    import { nil }
  end
end
