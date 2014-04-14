class CreateWorks < ActiveRecord::Migration
  def change
    create_table :works do |t|
      t.string :video_link
      t.string :header
      t.string :description

      t.timestamps
    end
  end
end
