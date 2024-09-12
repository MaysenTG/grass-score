# factories/accounts.rb
FactoryBot.define do
  factory :account do
    email { Faker::Internet.email }
    password { "password" }
    password_confirmation { "password" }

    after(:create) do |account|
      create_list(:game, 3, account: account)
    end
  end
end
