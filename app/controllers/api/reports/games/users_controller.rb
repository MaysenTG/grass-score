module Api
  module Reports
    module Games
      class UsersController < ApplicationController
        before_action :set_user

        def show
          render json: ::Reports::Games::PlayerScores.call(@user)
        end

        private

        def set_user
          @user = current_account.users.find(params[:id])
        end
      end
    end
  end
end
