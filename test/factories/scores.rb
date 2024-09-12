FactoryBot.define do
  factory :score do
    association :round, factory: :round
    association :player, factory: :player
    total_final_score { 0 }
  end
end
