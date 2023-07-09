FactoryBot.define do
  factory :user_information do
    first_name { "MyString" }
    last_name { "MyString" }
    date_of_birth { "2023-07-09" }
    hometown { "MyString" }
    about_me { "MyText" }
    user { nil }
  end
end
