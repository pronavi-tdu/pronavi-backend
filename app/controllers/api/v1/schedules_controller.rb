module Api
  module V1
    class SchedulesController < ApplicationController
      skip_before_action :verify_authenticity_token
      before_action :set_user

      def update
        @schedule = @user.schedules.first
      
        if @schedule.status_id == 5 && @schedule.status_lock.lock_boolean
          render json: { status: 'lock', message: 'Schedule is locked' }, status: :forbidden
        else
          if @schedule.update(schedule_params)
            if @schedule.status_id == 5 && Time.current < Time.current.end_of_day - 10.minutes
              status_lock = @schedule.status_lock
              status_lock.update(lock_boolean: true)
            end
            render json: { update: true }
          else
            render json: { status: 'Error', message: 'Failed to update schedule' }
          end
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
