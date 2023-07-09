FactoryBot.define do
  factory :friend_request do
    sender { nil }
    receiver { nil }
    accepted { false }
  end
end
