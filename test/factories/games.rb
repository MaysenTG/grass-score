FactoryBot.define do
  factory :game do
    sequence(:name) { |n| "Game #{n}" }
    association :account
  end
end
