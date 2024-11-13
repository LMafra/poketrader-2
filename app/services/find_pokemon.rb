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
    check_for_existing_pokemon(@new_pokemon)
    save_pokemon
    create_stats

    @new_pokemon
  rescue ActiveRecord::RecordInvalid => e
    if e.record.errors.details[:poke_index]&.any? { |error| error[:error] == :taken }
      raise AlreadyExistPokemon, "Pokemon already exists"
    else
      raise e
    end
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


  def check_for_existing_pokemon(new_pokemon)
    if Pokemon.find_by(poke_index: new_pokemon.poke_index)
      raise AlreadyExistPokemon, "Pokemon #{new_pokemon.name.capitalize} already exists"
    end
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

  def save_pokemon
    @new_pokemon.save!
  end
end
