class Bet < ApplicationRecord
  belongs_to :player
  belongs_to :round

  def update_player_money
    #Rojo o Negro = recupera el doble
    #Verde = recupera 15 veces lo apostado
    if option == round.result
      self.prize = round.result == "Verde" ? (amount * 15) : (amount * 2)
      self.player.get_prize(self.prize)
      save
    end
  end
end
