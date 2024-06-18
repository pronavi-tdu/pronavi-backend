class CreateStatusLocks < ActiveRecord::Migration[7.1]
  def change
    create_table :status_locks do |t|
      t.references :schedule, null: false, foreign_key: true
      t.boolean :lock_boolean, default: false
      
      t.timestamps
    end
  end
end
