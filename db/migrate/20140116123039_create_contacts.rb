class CreateContacts < ActiveRecord::Migration
  def change
    create_table :contacts do |t|
      t.string :email
      t.string :vimeo_id

      t.timestamps
    end
  end
end
