class Player < ApplicationRecord
  has_many :bets
  has_many :rounds, through: :bets


  validates :name, presence: true, uniqueness: { case_sensitive:false }
  validates :money, presence: true
end
