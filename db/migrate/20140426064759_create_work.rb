class CreateWork < ActiveRecord::Migration
  def change
    create_table :works do |t|
      t.string :header
      t.string :description
      t.string :work_link
      t.string :tile_image_link
      t.string :type
    end
  end
end
