class AddGridsterComponentsToWorks < ActiveRecord::Migration
  def change
    add_column :works, :grid_row, :integer
    add_column :works, :grid_column, :integer
    add_column :works, :grid_sizex, :integer
    add_column :works, :grid_sizey, :integer
  end
end
