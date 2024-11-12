# frozen_string_literal: true

class CreateTrades < ActiveRecord::Migration[8.0]
  def change
    create_table :trades, &:timestamps
  end
end
