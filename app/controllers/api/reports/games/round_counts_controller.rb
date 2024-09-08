module Api
  module Reports
    module Games
      class RoundCountsController < ApplicationController
        def index
          render json: ::Reports::Games::RoundsCount.call
        end
      end
    end
  end
end
