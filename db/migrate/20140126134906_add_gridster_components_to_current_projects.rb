class AddGridsterComponentsToCurrentProjects < ActiveRecord::Migration
  def change
    add_column :current_projects, :grid_row, :integer
    add_column :current_projects, :grid_column, :integer
    add_column :current_projects, :grid_sizex, :integer
    add_column :current_projects, :grid_sizey, :integer
  end
end
