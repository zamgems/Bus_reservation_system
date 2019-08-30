class AddForeignKeyToBuses < ActiveRecord::Migration[5.2]
  def change
  	remove_column :buses, :owner_id
  	add_reference :buses, :owner, foreign_key: true
  end
end
