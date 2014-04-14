class CreateAboutMeContents < ActiveRecord::Migration
  def change
    create_table :about_me_contents do |t|
      t.string :header
      t.string :description
      t.string :button_title

      t.timestamps
    end
  end
end
