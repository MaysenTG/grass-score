class ApplicationController < ActionController::Base
  # Rescue from template not found error.
  rescue_from ActionView::MissingTemplate, ActionController::MissingExactTemplate, with: :template_not_found
  rescue_from ActiveRecord::RecordNotFound, with: :render_404
  before_action :authenticate_account!

  private

  def return_to_game
    if @game || params[:game_id]
      @game ||= current_account.games.find(params[:game_id])
      redirect_to game_url(@game), notice: "The game has finished and cannot be changed." if @game.finished?
    end
  end

  def template_not_found
    redirect_to root_url, notice: "The page you are looking for does not exist."
  end

  def render_404
    redirect_to root_url, notice: "This record does not exist."
  end
end
