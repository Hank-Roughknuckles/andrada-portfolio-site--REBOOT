class GridPositionSerializedArrayToText < ActiveRecord::Migration
  def change
    change_column :grid_positions, :serialized_array, :text
  end
end
