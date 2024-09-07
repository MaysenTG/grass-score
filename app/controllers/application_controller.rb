class ApplicationController < ActionController::Base
  # Only allow modern browsers supporting webp images, web push, badges, import maps, CSS nesting, and CSS :has.
  allow_browser versions: :modern
  # Rescue from template not found error.
  rescue_from ActionView::MissingTemplate, ActionController::MissingExactTemplate, with: :template_not_found

  private

  def return_to_game
    if @game || params[:game_id]
      @game ||= Game.find(params[:game_id])
      redirect_to game_url(@game), notice: "The game has finished and cannot be changed." if @game.finished?
    end
  end

  def template_not_found
    redirect_to root_url, notice: "The page you are looking for does not exist."
  end
end
