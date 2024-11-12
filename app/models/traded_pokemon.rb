class TradedPokemon < ApplicationRecord
  belongs_to :pokemon
  belongs_to :trade

  validates :trainer, presence: true

  enum :trainer, { trainer_a: 0, trainer_b: 1 }
end
