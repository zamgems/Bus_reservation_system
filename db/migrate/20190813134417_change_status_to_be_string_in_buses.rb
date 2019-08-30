class ChangeStatusToBeStringInBuses < ActiveRecord::Migration[5.2]
  def change
  	change_column :buses, :status, :string
  end
end
