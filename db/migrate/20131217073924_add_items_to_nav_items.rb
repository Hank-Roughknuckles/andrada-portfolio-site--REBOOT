class AddItemsToNavItems < ActiveRecord::Migration
  def change
    rename_column :nav_items, :link_name, :link_1_name
    add_column :nav_items, :link_2_name, :string
    add_column :nav_items, :link_3_name, :string
    add_column :nav_items, :link_4_name, :string
    add_column :nav_items, :link_5_name, :string
  end
end
