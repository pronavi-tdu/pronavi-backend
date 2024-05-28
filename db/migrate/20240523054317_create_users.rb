class CreateUsers < ActiveRecord::Migration[7.1]
  def change
    create_table :users, id: false do |t|
      t.string :user_id, null: false, primary_key: true
      t.string :user_name, null: true
      t.bigint :department_id, null: true
      t.timestamps
    end
    add_foreign_key :users, :departments, column: :department_id, primary_key: :department_id
  end
end
