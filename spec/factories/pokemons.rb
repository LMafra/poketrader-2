# frozen_string_literal: true

FactoryBot.define do
  factory :pokemon do
    name { Faker::Games::Pokemon.name }
    weight { Faker::Number.decimal(l_digits: 2) }
    height { Faker::Number.decimal(l_digits: 2) }
    ability { Faker::Games::Pokemon.move }
    base_experience { Faker::Number.number(digits: 2) }
    sprite { Faker::Placeholdit.image }
    poke_index { Faker::Number.number(digits: 6) }
  end
end
