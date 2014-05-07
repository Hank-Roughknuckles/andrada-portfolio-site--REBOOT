class AddAncestryToCollections < ActiveRecord::Migration
  def change
    add_column :collections, :ancestry, :text
  end
end
