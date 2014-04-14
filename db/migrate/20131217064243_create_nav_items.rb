class CreateNavItems < ActiveRecord::Migration
  def change
    create_table :nav_items do |t|
      t.string :link_name

      t.timestamps
    end
  end
end
