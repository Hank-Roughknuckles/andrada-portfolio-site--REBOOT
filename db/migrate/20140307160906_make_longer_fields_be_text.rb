class MakeLongerFieldsBeText < ActiveRecord::Migration
  def change
    change_column :showreels, :description, :text
    change_column :current_projects, :description, :text
    change_column :works, :description, :text
  end
end
