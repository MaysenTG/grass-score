FactoryBot.define do
  factory :user do
    sequence(:name) { |n| "User #{n}" }
    association :account
  end
end
