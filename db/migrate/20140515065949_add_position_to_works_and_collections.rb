class AddPositionToWorksAndCollections < ActiveRecord::Migration
  def change
    add_column :works,        :position, :integer
    add_column :collections,  :position, :integer
  end
end
