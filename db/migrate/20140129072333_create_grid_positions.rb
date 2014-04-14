class CreateGridPositions < ActiveRecord::Migration
  def change
    create_table :grid_positions do |t|
      t.string :parent_name
      t.string :serialized_array
      t.timestamps
    end
  end
end
