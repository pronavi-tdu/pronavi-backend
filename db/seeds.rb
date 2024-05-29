#test data
department_data = {
  1 => 'RU',
  2 => 'RB',
  3 => 'RD',
  4 => 'RE',
  5 => 'RM',
  6 => 'RG'
}
department_data.each do |department_id, department_name|
  department = Department.create!(department_id: department_id, department_name: department_name)
end

user = User.create!(user_id: 'test123',user_name: '電大太郎',department_id: 1)

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
end

Schedule.create!(user_id: user.user_id, status_id: 6)