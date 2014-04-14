class RemoveWorksAndCurrentProjects < ActiveRecord::Migration
  def change
    drop_table :current_projects
    drop_table :works
  end
end
