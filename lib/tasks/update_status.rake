namespace :update_status do
    desc 'Update status_id at 0:00 '
    task update_status: :environment do
      User.find_each do |user|
        user.schedules.where.not(status_id: [4, 6]).update_all(status_id: 5)
      end
      StatusLock.update_all(lock_boolean: false)
      puts 'All user statuses updated and statuses unlock '
    end
  end