class CreateSchedules < ActiveRecord::Migration[7.1]
  def change
    create_table :schedules do |t|
      t.string :user_id, null: false
      t.bigint :status_id, null: false
      t.timestamps
    end
    add_foreign_key :schedules, :users, column: :user_id, primary_key: :user_id
    add_foreign_key :schedules, :statuses, column: :status_id, primary_key: :status_id
  end
end
