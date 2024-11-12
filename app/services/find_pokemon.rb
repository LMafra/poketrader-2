# frozen_string_literal: true

class FindPokemon
  extend ApplicationService

  class PokemonNotFound < StandardError; end
  class AlreadyExistPokemon < StandardError; end

  def initialize(pokemon_name)
    @pokemon = pokemon_name
  end

  def call
    @pokemon_info = PokeApi.get(pokemon: @pokemon.downcase)

    raise PokemonNotFound, "Empty pokemon name" unless @pokemon_info.name.present?

    @new_pokemon = create_pokemon
    @new_pokemon.save!
    create_stats

    @new_pokemon
  rescue StandardError => e
    if e.message == "Validation failed: Poke index has already been taken"
      raise AlreadyExistPokemon,
            "Pokemon already exists"
    end

    raise e
  end

  private

  def create_pokemon
    Pokemon.create(
      poke_index: @pokemon_info.id,
      name: @pokemon_info.name,
      height: @pokemon_info.height,
      weight: @pokemon_info.weight,
      base_experience: @pokemon_info.base_experience,
      ability: @pokemon_info.abilities.sample.ability.name,
      sprite: @pokemon_info.sprites.front_shiny
    )
  end

  def create_stats
    @pokemon_info.stats.each do |stat|
      Stat.create(
        name: stat.stat.name,
        base_value: stat.base_stat,
        pokemon_id: @new_pokemon.id
      )
    end
  end
end
