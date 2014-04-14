class RemoveShowreelsTable < ActiveRecord::Migration
  def change
    drop_table :showreels
  end
end
