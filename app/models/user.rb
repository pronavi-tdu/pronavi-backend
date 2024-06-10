class User < ApplicationRecord
  belongs_to :department
  has_many :schedules
  has_many :statuses, through: :schedules

  UNIVERSITY_IN = 1

  def within_university?(university_boolean)
    UNIVERSITY_IN == university_boolean.to_i
  end

end

#Userは多くのScheduleを持ち、Scheduleは一つのStatusを持つ
#Userは多くのStatusをScheduleを通じて持つ