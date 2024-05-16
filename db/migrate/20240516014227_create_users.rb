class CreateUsers < ActiveRecord::Migration[7.1]
  def change
    create_table :users, id: false do |t|
      t.string :user_id, null: false, primary_key: true
      t.string :password, null: false
      t.timestamps
    end
  end
end
