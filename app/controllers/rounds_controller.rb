class RoundsController < ApplicationController
  def index
    @rounds = Round.paginate(page: params[:page], per_page: 4)
  end
end
