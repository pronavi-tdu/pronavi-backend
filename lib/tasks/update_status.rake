namespace :update_status do
    desc 'Update status_id at 0:00 '
    task update_status: :environment do

      User.find_each do |user|
        schedules_update = user.schedules.where.not(status_id: [4, 6])
        
        schedules_update.each do |schedule|
          schedule.update(status_id: 5)
          schedule.status_detail.update(description: '')
        end
        
      end

      StatusLock.update_all(lock_boolean: false)
      # 日本時間を取得
      current_time = Time.now.in_time_zone('Asia/Tokyo').strftime("%Y-%m-%d %H:%M:%S")
      puts "All user statuses updated to 5 and statuses unlock at #{current_time} (JST)"
    end
  end