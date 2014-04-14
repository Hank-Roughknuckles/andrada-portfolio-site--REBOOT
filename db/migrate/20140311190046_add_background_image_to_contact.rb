class AddBackgroundImageToContact < ActiveRecord::Migration
  def change
    change_table :contacts do |t|
      t.attachment :background_image
    end
  end
end
