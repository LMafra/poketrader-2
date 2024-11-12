# frozen_string_literal: true

class TradesController < ApplicationController
  def index
    @trades = Trade.order(created_at: :desc).all
  end

  def create
    team_a = trade_params[:team_a]
    team_b = trade_params[:team_b]
    TradePokemons.call(team_a, team_b)
    head :ok
  end

  def new
    @available_pokemons = Pokemon.all
  end

  def destroy
    @trade = Trade.find(params[:id]).destroy
  end

  private

  def trade_params
    params.permit(team_a: [], team_b: [])
  end
end
