class AddMediaChoiceToCurrentProjects < ActiveRecord::Migration
  def change
    add_column :current_projects, :media_choice, :string
  end
end
