# frozen_string_literal: true

class Pokemon < ApplicationRecord
  validates_presence_of :name
  validates_uniqueness_of :poke_index

  has_many :stats, dependent: :destroy
  has_many :traded_pokemons

  scope :order_by_poke_index, -> { order(poke_index: :asc) }

  def total_stat
    stats.sum(&:base_value)
  end
end
