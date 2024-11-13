# frozen_string_literal: true

FactoryBot.define do
  factory :traded_pokemon do
    traits_for_enum :trainer, trainer_a: 0, trainer_b: 1

    trait :with_pokemon do
      pokemon { FactoryBot.build(:pokemon) }
    end

    trait :with_trade do
      trade { FactoryBot.build(:trade) }
    end
  end
end
