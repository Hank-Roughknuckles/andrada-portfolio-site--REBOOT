class DropNavItemsTable < ActiveRecord::Migration
  def change
    drop_table :nav_items
  end
end
