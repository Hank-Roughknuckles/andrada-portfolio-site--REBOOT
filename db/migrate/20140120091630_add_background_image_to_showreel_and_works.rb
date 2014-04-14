class AddBackgroundImageToShowreelAndWorks < ActiveRecord::Migration
  def change
    change_table :showreels do |t|
      t.attachment :background_image
    end

    change_table :works do |t|
      t.attachment :background_image
    end
  end
end
