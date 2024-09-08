module Api
  module Users
    class SuggestedController < ApplicationController
      def index
        @users = User.where("name ILIKE ?", "%#{params[:name]}%")
        render json: @users
      end
    end
  end
end
