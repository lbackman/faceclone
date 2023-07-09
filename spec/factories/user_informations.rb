FactoryBot.define do
  sequence :first_name do |n|
    "First_#{n}"
  end

  sequence :last_name do |n|
    "Last_#{n}"
  end

  factory :user_information do
    first_name
    last_name
    date_of_birth { "2023-05-03" }
    hometown { "MyString" }
    about_me { "MyText" }
    user nil
  end
end
