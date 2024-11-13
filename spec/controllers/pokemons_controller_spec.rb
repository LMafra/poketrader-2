# frozen_string_literal: true

require 'rails_helper'

RSpec.describe PokemonsController, type: :controller do
  describe "GET #index" do
    it "assigns @pokemons and renders the index template" do
      pokemon = FactoryBot.create(:pokemon)
      get :index
      expect(assigns(:pokemons)).to include(pokemon)
      expect(response).to render_template(:index)
    end
  end

  describe "POST #create" do
    context "when FindPokemon.call is successful" do
      it "calls FindPokemon with the correct name" do
        expect(FindPokemon).to receive(:call).with("Pikachu")
        post :create, params: { name: "Pikachu" }
      end
    end

    context "when FindPokemon raises PokemonNotFound" do
      it "raises an error with message 'Pokemon not found'" do
        allow(FindPokemon).to receive(:call).and_raise(FindPokemon::PokemonNotFound, "Pokemon not found")

        expect {
          post :create, params: { name: "NonExistentPokemon" }
        }.to raise_error("Pokemon not found")
      end
    end

    context "when FindPokemon raises AlreadyExistPokemon" do
      it "raises an error with message 'Pokemon already exists'" do
        allow(FindPokemon).to receive(:call).and_raise(FindPokemon::AlreadyExistPokemon, "Pokemon already exists")

        expect {
          post :create, params: { name: "ExistingPokemon" }
        }.to raise_error("Pokemon already exists")
      end
    end
  end
end
