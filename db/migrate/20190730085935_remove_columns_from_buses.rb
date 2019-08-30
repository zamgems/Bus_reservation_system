class RemoveColumnsFromBuses < ActiveRecord::Migration[5.2]
  def change
  	remove_column :buses, :added_seats
  	remove_column :buses, :reserved_seats
  end
end
