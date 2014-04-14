class CreatePhotos < ActiveRecord::Migration
  def change
    create_table :photos do |t|
      t.text :link
      t.text :type

      t.timestamps
    end
  end
end
