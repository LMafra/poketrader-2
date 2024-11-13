# frozen_string_literal: true

FactoryBot.define do
  factory :stat do
    name { Faker::Games::ClashOfClans.rank }
    base_value { Faker::Number.number(digits: 2) }

    trait :with_pokemon do
      pokemon { FactoryBot.build :pokemon }
    end
  end
end
