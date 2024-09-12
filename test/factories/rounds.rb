FactoryBot.define do
  factory :round do
    association :game, factory: :game
    finished { false }
  end
end
