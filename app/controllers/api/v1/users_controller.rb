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
        if params[:department_id]
          users = User.where(department_id: params[:department_id])
        else
          users = User.all
        end
        
        users = users.includes(:statuses, :department)
        
        if users.empty?
          render json: { message: "No users found" }, status: 400
        else
          render json: users.to_json(include: [:statuses, :department])
        end
      end

      def update_user_name
        user = User.find_by(user_id: params[:user_id])
        if user.update(user_name: params[:user_name])
          render json: { message: "User's name updated successfully" }, status: 200
        else
          render json: { error: user.errors.full_messages }, status: 400
        end
      end

      def update_user_department
        user = User.find_by(user_id: params[:user_id])
        if user.update(department_id: params[:department_id])
          render json: { message: "User's department updated successfully" }, status: 200
        else
          render json: { error: user.errors.full_messages }, status: 400
        end
      end

      private
      def user_params
        params.require(:user).permit(:user_id)
      end
    end
  end
end