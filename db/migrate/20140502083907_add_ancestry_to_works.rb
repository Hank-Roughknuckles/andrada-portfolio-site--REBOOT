class AddAncestryToWorks < ActiveRecord::Migration
  def change
    add_column :works, :ancestry, :text
    add_index :works, :ancestry
  end
end
