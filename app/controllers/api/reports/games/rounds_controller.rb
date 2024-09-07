module Api
  module Reports
    module Games
      class RoundsController < ApplicationController
        before_action :set_game

        def show
          render json: ::Reports::Games::Rounds.call(@game)
        end

        private

        def set_game
          @game = Game.find(params[:id]) if params[:id]
        end
      end
    end
  end
end
