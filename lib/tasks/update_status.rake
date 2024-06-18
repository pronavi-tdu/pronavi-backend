namespace :update_status do
    desc 'Update status_id at 0:00 '
    task update_status: :environment do
      User.find_each do |user|
        user.schedules.update_all(status_id: 5)
      end
      puts 'All user statuses have been updated to 5'
    end
  end