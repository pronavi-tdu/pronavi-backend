class User < ApplicationRecord
  belongs_to :department
  has_many :schedules
  has_many :statuses, through: :schedules

  UNIVERSITY_LATITUDE_RANGE = (35.981615..35.988737) #大学の緯度範囲
  UNIVERSITY_LONGITUDE_RANGE = (139.368220..139.376497) #大学の経度範囲

  def within_university_bounds?(latitude, longitude)
    UNIVERSITY_LATITUDE_RANGE.cover?(latitude) && UNIVERSITY_LONGITUDE_RANGE.cover?(longitude)
  end

end

#Userは多くのScheduleを持ち、Scheduleは一つのStatusを持つ
#Userは多くのStatusをScheduleを通じて持つ