class AddImageAttachmentToCurrentProjects < ActiveRecord::Migration
  def change
    change_table :current_projects do |t|
      t.attachment :media_image
    end
  end
end
