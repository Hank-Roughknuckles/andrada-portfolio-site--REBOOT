class AddGridTileImageToWorks < ActiveRecord::Migration
  def change
    change_table :works do |t|
      t.attachment :grid_tile_image
    end
  end
end
