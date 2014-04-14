class AddAttachmentBackgroundImageToAboutMeContents < ActiveRecord::Migration
  def self.up
    change_table :about_me_contents do |t|
      t.attachment :background_image
    end
  end

  def self.down
    drop_attached_file :about_me_contents, :background_image
  end
end
