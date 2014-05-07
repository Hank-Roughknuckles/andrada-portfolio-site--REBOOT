class AddTileImageLinkToCollection < ActiveRecord::Migration
  def change
    add_column :collections, :tile_image_link, :string
  end
end
