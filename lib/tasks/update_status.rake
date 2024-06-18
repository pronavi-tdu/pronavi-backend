namespace :update_status do
    desc 'Update status_id at 0:00 '
    task update_status: :environment do
      User.find_each do |user|
        user.schedules.update_all(status_id: 5)
      end
      StatusLock.update_all(lock_boolean: false)
      puts 'All user statuses updated to 5 and statuses unlock '
    end
  end