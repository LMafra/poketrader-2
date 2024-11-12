# frozen_string_literal: true

class TradePokemons
  extend ApplicationService

  POKEMON_BASE_STATUS_DIFFERENCE = 60

  class TradeNotFair < StandardError; end

  def initialize(team_a, team_b)
    @team_a = team_a
    @team_b = team_b
  end

  def call
    raise TradeNotFair, "Trade is not fair" unless check_fairness

    @trade = Trade.new
    swap_team
    @trade.save!
  end

  private

  def swap_team
    change_trainer(@team_a, TradedPokemon.trainers[:trainer_a])
    change_trainer(@team_b, TradedPokemon.trainers[:trainer_b])
  end

  def change_trainer(pokemons, trainer)
    pokemons.map do |pokemon|
      found_pokemon = Pokemon.find_by_name(pokemon)
      @trade.add_pokemon(found_pokemon, trainer)
    end
  end

  def check_fairness
    team_a_stats = @team_a.map { |pokemon| Pokemon.find_by_name(pokemon).total_stat }.sum
    team_b_stats = @team_b.map { |pokemon| Pokemon.find_by_name(pokemon).total_stat }.sum

    (team_a_stats - team_b_stats).abs < POKEMON_BASE_STATUS_DIFFERENCE
  end
end
