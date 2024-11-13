# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Pokemon, type: :model do
  subject {  FactoryBot.create :pokemon }

  it { should have_many(:stats) }
  it { should have_many(:traded_pokemons) }
  it { should validate_presence_of(:name) }
  it { should validate_uniqueness_of(:poke_index) }
  it { should be_valid }

  describe '#total_stat' do
    it 'returns the sum of base_value for all associated stats' do
      pokemon = FactoryBot.create :pokemon
      pokemon.stats.create(name: 'hp', base_value: 100)
      pokemon.stats.create(name: 'attack', base_value: 120)
      pokemon.stats.create(name: 'defense', base_value: 150)

      expected_total_stat = 100 + 120 + 150

      expect(pokemon.total_stat).to eq(expected_total_stat)
    end
    it "returns 0 if there is no stats associated" do
      pokemon = FactoryBot.create :pokemon

      expect(pokemon.total_stat).to eq(0)
    end
  end
end
