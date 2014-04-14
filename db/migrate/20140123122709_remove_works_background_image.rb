class RemoveWorksBackgroundImage < ActiveRecord::Migration
  def change
   remove_column :works, :background_image_file_name
   remove_column :works, :background_image_content_type
   remove_column :works, :background_image_file_size
   remove_column :works, :background_image_updated_at
  end
end
