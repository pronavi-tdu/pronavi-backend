module Api
  module V1
    class UsersController < ApplicationController
      skip_before_action :verify_authenticity_token

      def register
        @user = User.new(user_params)
        status_id = params[:status_id] || 6 
        if @user.save
          @user.schedules.create!(status_id: status_id)
          render json: {registration: true}, status: 201
        else
          render status: 400
        end
      end
      
      def index
        users = User.includes(:schedules, :department)
        if users.empty?
          render json: { message: "No users found" }, status: 400
        else
          render json: users.map { |user| 
            {
              User_id: user.user_id,
              User_name: user.user_name,
              Department_id: user.department_id,
              Status_id: user.schedules.first&.status_id 
            }
          }, status: 200
        end
      end

      def locations
        user = User.find_by(user_id: params[:user_id])
        
        if user
          university_boolean = params[:location][:university_boolean].to_i
          
          schedule = user.schedules.first
          
          if user.within_university?(university_boolean)
            if schedule.status_id == 5
              schedule.update(status_id: 2)
            end
          else
            if schedule.status_id != 5
              schedule.update(status_id: 5)
            end
          end

          render json: {status: "success",message: "Location received" }, status: 200
        else
          render json: { error: "error" }, status: 404
        end
      end

      def update_user_name
        user = User.find_by(user_id: params[:user_id])
        if user.update(user_name: params[:user_name])
          render json: { "update": true }, status: 200
        else
          render json: { error: user.errors.full_messages }, status: 400
        end
      end

      def update_user_department
        user = User.find_by(user_id: params[:user_id])
        if user.update(department_id: params[:department_id])
          render json: { "update": true }, status: 200
        else
          render json: { error: user.errors.full_messages }, status: 400
        end
      end

      private
      def user_params
        params.require(:user).permit(:user_id, :user_name, :department_id)
      end

      def location_params
        params.require(:user).permit(:user_id, location: [:latitude, :longitude])
      end

    end
  end
end