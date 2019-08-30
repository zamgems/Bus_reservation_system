class AddSlugToBuses < ActiveRecord::Migration[5.2]
  def change
    add_column :buses, :slug, :string
    add_index :buses, :slug
  end
end
