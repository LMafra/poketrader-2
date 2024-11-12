# frozen_string_literal: true

class CreateTradedPokemons < ActiveRecord::Migration[8.0]
  def change
    create_table :traded_pokemons do |t|
      t.integer :trainer
      t.references :pokemon, foreign_key: true
      t.references :trade, foreign_key: true
      t.timestamps
    end
  end
end
