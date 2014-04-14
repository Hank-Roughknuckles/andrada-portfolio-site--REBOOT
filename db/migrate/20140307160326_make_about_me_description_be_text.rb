class MakeAboutMeDescriptionBeText < ActiveRecord::Migration
  def change
    change_column :about_me_contents, :description, :text
  end
end
