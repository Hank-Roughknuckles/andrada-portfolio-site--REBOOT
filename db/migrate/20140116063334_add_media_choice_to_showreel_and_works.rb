class AddMediaChoiceToShowreelAndWorks < ActiveRecord::Migration
  def change
    add_column :showreels, :media_choice, :string
    add_column :works, :media_choice, :string
  end
end
