# frozen_string_literal: true

# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# This file is the source Rails uses to define your schema when running `bin/rails
# db:schema:load`. When creating a new database, `bin/rails db:schema:load` tends to
# be faster and is potentially less error prone than running all of your
# migrations from scratch. Old migrations may fail to apply correctly if those
# migrations use external dependencies or application code.
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema[8.0].define(version: 20_241_111_205_521) do
  create_table 'pokemons', force: :cascade do |t|
    t.string 'name'
    t.float 'weight'
    t.float 'height'
    t.string 'ability'
    t.integer 'base_experience'
    t.string 'sprite'
    t.integer 'poke_index'
    t.datetime 'created_at', null: false
    t.datetime 'updated_at', null: false
  end

  create_table 'stats', force: :cascade do |t|
    t.string 'name'
    t.integer 'base_value'
    t.integer 'pokemon_id'
    t.datetime 'created_at', null: false
    t.datetime 'updated_at', null: false
    t.index ['pokemon_id'], name: 'index_stats_on_pokemon_id'
  end

  create_table 'traded_pokemons', force: :cascade do |t|
    t.integer 'trainer'
    t.integer 'pokemon_id'
    t.integer 'trade_id'
    t.datetime 'created_at', null: false
    t.datetime 'updated_at', null: false
    t.index ['pokemon_id'], name: 'index_traded_pokemons_on_pokemon_id'
    t.index ['trade_id'], name: 'index_traded_pokemons_on_trade_id'
  end

  create_table 'trades', force: :cascade do |t|
    t.datetime 'created_at', null: false
    t.datetime 'updated_at', null: false
  end

  add_foreign_key 'stats', 'pokemons'
  add_foreign_key 'traded_pokemons', 'pokemons'
  add_foreign_key 'traded_pokemons', 'trades'
end
