class CreateStatusDetails < ActiveRecord::Migration[7.1]
  def change
    create_table :status_details do |t|
      t.references :schedule, null: false, foreign_key: true
      t.string :description, default: ''

      t.timestamps
    end
  end
end
