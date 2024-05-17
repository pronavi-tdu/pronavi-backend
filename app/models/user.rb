class User < ApplicationRecord
    has_many :schedules

    def get_status_name(schedule_id)
        schedule = self.schedules.find(schedule_id)
        
        schedule.status.status_name
    end
    
end
