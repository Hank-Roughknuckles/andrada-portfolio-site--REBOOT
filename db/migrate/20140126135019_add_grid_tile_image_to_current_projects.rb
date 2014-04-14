class AddGridTileImageToCurrentProjects < ActiveRecord::Migration
  def change
    change_table :current_projects do |t|
      t.attachment :grid_tile_image
    end
  end
end
