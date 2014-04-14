class CreateCurrentProjects < ActiveRecord::Migration
  def change
    create_table :current_projects do |t|
      t.string :header
      t.string :description
      t.integer :progress
      t.string :media_link

      t.timestamps
    end
  end
end
