module Api
  module V1
    class UsersController < ApplicationController
      skip_before_action :verify_authenticity_token

      def register
        @user = User.new(user_params)
        status_id = params[:status_id] || 6 
        if @user.save
          @user.schedules.create!(status_id: status_id)
          render json: { user: @user }, status: 201
        else
          render status: 400
        end
      end
      
      def index
        users = User.all 
        if users.empty?
          render status: 400
        else
          render json: { users: users },status: 200
        end
      end

      private
      def user_params
        params.require(:user).permit(:user_id, :password)
      end
    end
  end
end
