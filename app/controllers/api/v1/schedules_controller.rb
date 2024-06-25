module Api
  module V1
    class SchedulesController < ApplicationController
      skip_before_action :verify_authenticity_token
      before_action :set_user

      def update
        @schedule = @user.schedules.first

          if @schedule.update(schedule_params)
            @schedule.status_detail.update(description: '')

            if @schedule.status_id == 5 && Time.current < Time.current.end_of_day - 10.minutes
              status_lock = @schedule.status_lock
              status_lock.update(lock_boolean: true)

            elsif @schedule.status_lock.lock_boolean
              status_lock = @schedule.status_lock
              status_lock.update(lock_boolean: false)

            end

            render json: { update: true }
          else
            render json: { status: 'Error', message: 'Failed to update schedule' }
          end
      end

      def update_detail
        @schedule = @user.schedules.first
        status_detail = @schedule.status_detail
        if status_detail.update(description: params[:status_details][:description])
          render json: { "update": true }, status: 200
        else
          render json: { error: user.errors.full_messages }, status: 400
        end
      end
      
      private
      def set_user
        @user = User.find(params[:user_id])
      end

      def schedule_params
        params.require(:schedule).permit(:status_id)
      end
    end
  end
end
