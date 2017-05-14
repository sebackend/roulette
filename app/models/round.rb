class Round < ApplicationRecord
  has_many :bets
  has_many :players, through: :bets

  after_initialize :init
  after_create :add_players_and_bets, :give_prize

  #traer siempre las últimas rondas creadas
  default_scope -> { order(created_at: :desc) }

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

  def give_prize
    bets.each do |bet|
      bet.update_player_money
    end
  end

  #Comprobar si el clima es mayor a 25°C los proximos 7 días
  def weather_over_25_degrees?
    result = false
    require 'rest-client'
    require 'crack'

    RestClient.get('http://www.myweather2.com/developer/weather.ashx?uac=WxnCRiKFpK&uref=f37337a2-9fcb-44d8-b0b7-91b226b108e8'){ |response, request, result, &block|
      case response.code
      when 200
        data = Crack::XML.parse(response)
        if data.key?("weather") && data["weather"].key?("forecast")
          data["weather"]["forecast"].each do |child|
            result = child["day_max_temp"].to_i > 25
            break if result
          end  
        end

        return result
      else
        return result
      end
    }
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
