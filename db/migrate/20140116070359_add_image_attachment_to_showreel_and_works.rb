class AddImageAttachmentToShowreelAndWorks < ActiveRecord::Migration
  def change
    change_table :showreels do |t|
      t.attachment :media_image
    end

    change_table :works do |t|
      t.attachment :media_image
    end
  end
end
