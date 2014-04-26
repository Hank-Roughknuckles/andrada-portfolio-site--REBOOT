class CreateVideoWorks < ActiveRecord::Migration
  def change
    create_table :video_works do |t|

      t.timestamps
    end
  end
end
