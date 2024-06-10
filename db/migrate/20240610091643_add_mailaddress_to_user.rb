class AddMailaddressToUser < ActiveRecord::Migration[7.1]
  def change
    add_column :users, :mailaddress, :string
  end
end
