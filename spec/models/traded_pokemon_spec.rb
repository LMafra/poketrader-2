# frozen_string_literal: true

require 'rails_helper'

RSpec.describe TradedPokemon, type: :model do
  subject { FactoryBot.create :traded_pokemon, :trainer_a, :with_pokemon, :with_trade }

  it { should belong_to :pokemon }
  it { should belong_to :trade }
  it { should validate_presence_of :trainer }
  it { should be_valid }
end
