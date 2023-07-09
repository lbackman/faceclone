FactoryBot.define do
  factory :friend_request do
    sender { association :user }
    receiver { association :user }
    accepted { false }
  end
end
