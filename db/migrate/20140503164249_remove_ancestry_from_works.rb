class RemoveAncestryFromWorks < ActiveRecord::Migration
  def change
    remove_column :works, :ancestry
  end
end
