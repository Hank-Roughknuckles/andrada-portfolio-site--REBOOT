class AddFacebookToContact < ActiveRecord::Migration
  def change
    add_column :contacts, :facebook, :string
  end
end
