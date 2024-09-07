class ApplicationController < ActionController::Base
  # Only allow modern browsers supporting webp images, web push, badges, import maps, CSS nesting, and CSS :has.
  allow_browser versions: :modern

  before_action :return_to_game, only: %i[ create update destroy new edit ]

  private

  def return_to_game
    if @game || params[:game_id]
      @game ||= Game.find(params[:game_id])
      redirect_to game_url(@game), notice: "The game has finished and cannot be changed." if @game.finished?
    end
  end
end
