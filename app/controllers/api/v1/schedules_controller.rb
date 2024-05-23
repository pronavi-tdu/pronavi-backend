module Api
  module V1
    class SchedulesController < ApplicationController
      skip_before_action :verify_authenticity_token
      before_action :set_user

      def update
        @schedule = @user.schedules.first
        if @schedule.update(schedule_params)
          render json: { status: 'Success', message: 'Schedule updated successfully' }, status: :ok
        else
          render json: { status: 'Error', message: 'Failed to update schedule' }, status: :unprocessable_entity
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

# http://hostアドレス/api/v1/users/user_id/schedules
#{
# "schedule":{
#   "status_id": 更新したい番号
# }
#}