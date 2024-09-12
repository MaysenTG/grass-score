FactoryBot.define do
  factory :player do
    sequence(:name) { |n| "Player #{n}" }
    association :game
    association :user, factory: :user
  end
end
