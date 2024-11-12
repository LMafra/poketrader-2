# frozen_string_literal: true

class Trade < ApplicationRecord
  has_many :traded_pokemons, dependent: :destroy

  def add_pokemon(pokemon, trainer)
    traded_pokemons << TradedPokemon.new(pokemon: pokemon, trainer: trainer)
  end

  def trainer_a_pokemons
    traded_pokemons.select(&:trainer_a?)
  end

  def trainer_b_pokemons
    traded_pokemons.select(&:trainer_b?)
  end
end
