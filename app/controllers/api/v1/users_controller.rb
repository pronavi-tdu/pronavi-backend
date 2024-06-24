module Api
  module V1
    class UsersController < ApplicationController
      skip_before_action :verify_authenticity_token

      def register
        @user = User.new(user_params)
        status_id = params[:status_id] || 6 
        if @user.save
          schedule = @user.schedules.create(status_id: status_id)
    
          if schedule
            schedule.create_status_lock
            schedule.create_status_detail
            render json: {registration: true}, status: 201
          else
            render json: {registration: false}, status: 400
          end
          
        else
          render status: 400
        end
      end
      
      def index
        users = User.includes(department: [], schedules: :status_detail)
        if users.empty?
          render json: { message: "No users found" }, status: 400
        else
          render json: users.map { |user| 
            schedule = user.schedules.first
            {
              User_id: user.user_id,
              User_name: user.user_name,
              Department_id: user.department_id,
              Mailaddress: user.mailaddress,
              Status_id: schedule&.status_id,
              Description: schedule&.status_detail&.description
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
            if schedule.status_id == 5 && schedule.status_lock.lock_boolean == false
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

      def check_mailaddress
        mailaddress = params[:mailaddress]
        
        if mailaddress.present?
          user = User.find_by(mailaddress: mailaddress)
          if user
            render json: {status: 1}
          else
            render json: {status: 0}
          end
        else
          render json: { error: 'parameter error' }, status: :bad_request
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
        params.require(:user).permit(:user_id, :user_name, :department_id, :mailaddress)
      end

    end
  end
end