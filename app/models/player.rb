class Player < ApplicationRecord
  has_many :bets
  has_many :rounds, through: :bets


  validates :name, presence: true, uniqueness: { case_sensitive:false }
  validates :money, presence: true

  after_initialize :set_initial_money

  def set_initial_money
    self.money ||= 10000
  end

  def make_bet(over_25_degrees, choice, round_id)
    amount = 0
    if over_25_degrees
      amount = money * rand(4..10) / 100
    else
      amount = money * rand(8..15) / 100
    end

    bet = Bet.new(amount: amount, option: choice, round_id: round_id)
    bets << bet
    self.money = money - amount
    save

    return bet
  end

  def get_prize(amount) 
    self.money = money + amount
    save
  end


end
