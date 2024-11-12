# frozen_string_literal: true

class CreatePokemons < ActiveRecord::Migration[8.0]
  def change
    create_table :pokemons do |t|
      t.string 'name'
      t.float 'weight'
      t.float 'height'
      t.string 'ability'
      t.integer 'base_experience'
      t.string 'sprite'
      t.integer 'poke_index'
      t.timestamps
    end
  end
end
