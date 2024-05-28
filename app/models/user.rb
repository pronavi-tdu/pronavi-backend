class User < ApplicationRecord
    belongs_to :department, optional: true
    has_many :schedules
    has_many :statuses, through: :schedules
end
#Userは多くのScheduleを持ち、Scheduleは一つのStatusを持つ
#Userは多くのStatusをScheduleを通じて持つ