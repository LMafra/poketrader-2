# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Trade, type: :model do
  subject(:trade) { FactoryBot.create :trade }
  subject(:pokemon) { FactoryBot.create :pokemon }
  subject(:trainer_a) { :trainer_a }
  subject(:trainer_b) { :trainer_b }

  describe "#add_pokemon" do
    it "adds a traded pokemon to the trade" do
      expect {
        trade.add_pokemon(pokemon, trainer_a)
      }.to change { trade.traded_pokemons.count }.by(1)
    end

    it "assigns the correct pokemon and trainer" do
      trade.add_pokemon(pokemon, trainer_a)
      traded_pokemon = trade.traded_pokemons.last
      expect(traded_pokemon.pokemon).to eq(pokemon)
      expect(traded_pokemon.trainer).to eq(trainer_a.to_s)
    end
  end

  describe "#trainer_a_pokemons" do
    it "returns only pokemons for trainer A" do
      trade.add_pokemon(pokemon, trainer_a)
      other_pokemon = FactoryBot.create(:pokemon, name: "Charmander")
      trade.add_pokemon(other_pokemon, trainer_b)

      result = trade.trainer_a_pokemons
      expect(result.map(&:pokemon)).to contain_exactly(pokemon)
    end
  end

  describe "#trainer_b_pokemons" do
    it "returns only pokemons for trainer B" do
      trade.add_pokemon(pokemon, trainer_a)
      other_pokemon = FactoryBot.create(:pokemon, name: "Bulbasaur")
      trade.add_pokemon(other_pokemon, trainer_b)

      result = trade.trainer_b_pokemons
      expect(result.map(&:pokemon)).to contain_exactly(other_pokemon)
    end
  end
end
