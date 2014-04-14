class RenameVideoLinkToMediaLink < ActiveRecord::Migration
  def change
    rename_column :showreels, :video_link, :media_link
    rename_column :works, :video_link, :media_link
  end
end
