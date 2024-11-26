# frozen_string_literal: true

require 'rails_helper'

RSpec.describe TradesController, type: :controller do
  describe "GET #index" do
    it "assigns @trades in descending order of creation" do
      older_trade = FactoryBot.create(:trade, created_at: 1.day.ago)
      newer_trade = FactoryBot.create(:trade, created_at: Time.now)

      get :index
      expect(assigns(:trades)).to eq([ newer_trade, older_trade ])
    end

    it "renders the index template" do
      get :index
      expect(response).to render_template(:index)
    end
  end

  describe "POST #create" do
    let(:team_a) { %w[Pikachu Bulbasaur] }
    let(:team_b) { %w[Charmander Squirtle] }

    context "when TradePokemons.call succeeds" do
      it "calls TradePokemons with the correct parameters" do
        expect(TradePokemons).to receive(:call).with(team_a, team_b)
        post :create, params: { team_a: team_a, team_b: team_b }
      end

      it "responds with status ok" do
        allow(TradePokemons).to receive(:call)
        post :create, params: { team_a: team_a, team_b: team_b }
        expect(response).to have_http_status(:ok)
      end
    end

    context "when TradePokemons raises an error" do
      it "raises the error" do
        allow(TradePokemons).to receive(:call).and_raise(StandardError, "Trade failed")
        expect {
          post :create, params: { team_a: team_a, team_b: team_b }
        }.to raise_error("Trade failed")
      end
    end
  end

  describe "GET #new" do
    it "assigns @available_pokemons to all Pokémon" do
      pokemon = FactoryBot.create(:pokemon)
      get :new
      expect(assigns(:available_pokemons)).to include(pokemon)
    end

    it "renders the new template" do
      get :new
      expect(response).to render_template(:new)
    end
  end

  describe "DELETE #destroy" do
    it "destroys the requested trade" do
      trade = FactoryBot.create(:trade)
      expect {
        delete :destroy, params: { id: trade.id }
      }.to change(Trade, :count).by(-1)
    end

    it "responds with a redirect or appropriate status" do
      trade = FactoryBot.create(:trade)
      delete :destroy, params: { id: trade.id }
      expect(response).to have_http_status(:no_content) # Change to :redirect if applicable
    end
  end
end
