require 'rails_helper'

RSpec.describe FindPokemon do
  describe "#call" do
    let(:pokemon_name) { "Pikachu" }

    let(:poke_api_response) do
      instance_double(
        "PokeApiResponse",
        name: "pikachu",
        id: 25,
        height: 4,
        weight: 60,
        base_experience: 112,
        abilities: [ instance_double("Ability", ability: instance_double("AbilityDetail", name: "static")) ],
        sprites: instance_double("Sprites", front_shiny: "sprite_url"),
        stats: [
          stat: instance_double("StatDetail", name: "speed", base_stat: 90)
        ]
      )
    end

    before do
      allow(PokeApi).to receive(:get).and_return(poke_api_response)
      Pokemon.delete_all
    end

    context "when the Pokémon is successfully fetched and saved" do
      it "creates a new Pokémon with the correct attributes" do
        result = described_class.call(pokemon_name)
        expect(result).to be_a(Pokemon)
        expect(result.name).to eq("pikachu")
        expect(result.poke_index).to eq(25)
        expect(result.ability).to eq("static")
        expect(result.sprite).to eq("sprite_url")
      end

      it "creates associated stats for the Pokémon" do
        result = described_class.call(pokemon_name)
        expect(result.stats.count).to eq(2)
        expect(result.stats.pluck(:name)).to contain_exactly("speed", "attack")
        expect(result.stats.pluck(:base_value)).to contain_exactly(90, 55)
      end
    end

    context "when the Pokémon name is empty or invalid" do
      let(:pokemon_name) { "" }

      it "raises PokemonNotFound error" do
        allow(PokeApi).to receive(:get).with(pokemon: "").and_raise(NoMethodError)
        expect { described_class.call(pokemon_name) }.to raise_error(FindPokemon::PokemonNotFound, "Empty pokemon name")
      end
    end

    context "when the Pokémon already exists" do
      before do
        FactoryBot.create(:pokemon, poke_index: 25, name: "pikachu")
      end

      it "raises AlreadyExistPokemon error" do
        expect { described_class.call(pokemon_name) }.to raise_error(FindPokemon::AlreadyExistPokemon, "Pokemon Pikachu already exists")
      end
    end

    context "when a validation error occurs" do
      before do
        allow_any_instance_of(Pokemon).to receive(:save!).and_raise(ActiveRecord::RecordInvalid.new(Pokemon.new))
      end

      it "raises the validation error" do
        expect { described_class.call(pokemon_name) }.to raise_error(ActiveRecord::RecordInvalid)
      end
    end
  end
end
