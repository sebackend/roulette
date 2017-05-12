class Round < ApplicationRecord
  has_many :bets
  has_many :players, through: :bets


  #Antes de comenzar una ronda, comprobar el clima es mayor a 25°C los proximos 7 días
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
end
