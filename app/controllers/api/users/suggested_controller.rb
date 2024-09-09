module Api
  module Users
    class SuggestedController < ApplicationController
      def index
        @users = current_account.users.where("name ILIKE ?", "%#{params[:name]}%")
        render json: @users
      end
    end
  end
end
