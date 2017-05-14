class RoundsController < ApplicationController
  def index
    @rounds = Round.includes(:bets)
  end
end
