
user = User.create!(user_id: 'test123', password: 'password')

status_data = {
  1 => 'Lecture',
  2 => 'Labo',
  3 => 'Mtg',
  4 => 'Out',
  5 => 'B_trip',
  6 => 'Private'
}

status_data.each do |status_id, status_name|
  status = Status.create!(status_id: status_id, status_name: status_name)
  Schedule.create!(user_id: user.user_id, status_id: status.status_id)
end

#test
