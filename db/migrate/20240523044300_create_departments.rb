class CreateDepartments < ActiveRecord::Migration[7.1]
  def change
    create_table :departments, id:false do |t|
      t.bigint :department_id, primary_key: true
      t.string :department_name
      t.timestamps
    end
  end
end
