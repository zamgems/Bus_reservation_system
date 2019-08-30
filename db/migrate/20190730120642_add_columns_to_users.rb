class AddColumnsToUsers < ActiveRecord::Migration[5.2]
  def change
  	add_column :users, :role, :string
  	add_column :users, :status, :string
  end
end
