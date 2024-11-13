# frozen_string_literal: true

class PokemonsController < ApplicationController
  def index
    @pokemons = Pokemon.includes(:stats).all
  end

  def create
    FindPokemon.call(pokemon_params[:name])
  rescue FindPokemon::PokemonNotFound, FindPokemon::AlreadyExistPokemon => e
    raise e.message
  end

  private

  def pokemon_params
    params.permit(:name)
  end
end
