class AddFolderIdToWork < ActiveRecord::Migration
  def change
    add_column :works, :folder_id, :string
  end
end
