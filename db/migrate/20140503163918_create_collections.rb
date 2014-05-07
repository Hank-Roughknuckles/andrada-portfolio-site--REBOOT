class CreateCollections < ActiveRecord::Migration
  def change
    create_table :collections do |t|
      t.string :type

      t.timestamps
    end
  end
end
