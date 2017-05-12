class Player < ApplicationRecord
  has_many :bets
  has_many :rounds, through: :bets


  validates :name, presence: true, uniqueness: { case_sensitive:false }
  validates :money, presence: true

  after_initialize :init

  def init
    self.money ||= 10000
  end

  def make_bet(over_25_degrees)
    # TODO : fix este hardcoded, cambiar tipo apuesta si está sobre 25°C
    bet = Bet.new(amount: 10, option: "Verde")
    self.bets << bet
    
    # restar dinero

    return bet
  end

end
