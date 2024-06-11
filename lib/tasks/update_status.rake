namespace :update_status do
    desc 'Update status_id of all users to 5'
    task update_status: :environment do
      User.find_each do |user|
        user.schedules.update_all(status_id: 5)
      end
      puts 'All user statuses have been updated to 5'
    end
  end