class Round < ApplicationRecord
  has_many :bets
  has_many :players, through: :bets

  after_initialize :init
  after_create :add_players_and_bets

  def init
    self.result ||= set_option # opcion ganadora
    self.over_25_degrees ||= weather_over_25_degrees?
  end

  #Agregar a los jugadores con sus respectivas apuestas
  def add_players_and_bets
    Player.where('money > ?', 0).each do |player|
      bet = player.make_bet(over_25_degrees, set_option, id)
    end
  end


  #Comprobar si el clima es mayor a 25°C los proximos 7 días
  def weather_over_25_degrees?
    result = false
    require 'rest-client'
    require 'crack'

    response = RestClient.get('http://www.myweather2.com/developer/weather.ashx?uac=WxnCRiKFpK&uref=f37337a2-9fcb-44d8-b0b7-91b226b108e8')
    data = Crack::XML.parse(response)

    data["weather"]["forecast"].each do |child|
      child["day_max_temp"].to_i > 25 ? result = true : nil
    end
    return result
  end

  

  def set_option
    options = {
      "Verde" => 2,
      "Rojo" => 49,
      "Negro" => 49
    }

    Pickup.new(options).pick
  end
end
