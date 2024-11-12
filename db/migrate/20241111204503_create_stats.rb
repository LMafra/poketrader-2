# frozen_string_literal: true

class CreateStats < ActiveRecord::Migration[8.0]
  def change
    create_table :stats do |t|
      t.string :name
      t.integer :base_value
      t.references :pokemon, foreign_key: true
      t.timestamps
    end
  end
end
