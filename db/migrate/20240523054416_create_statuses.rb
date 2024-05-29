class CreateStatuses < ActiveRecord::Migration[7.1]
  def change
    create_table :statuses, id:false do |t|
      t.bigint :status_id, null:false, primary_key: true
      t.string :status_name, null:false
      t.timestamps
    end
  end
end