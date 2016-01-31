class AddAdminToDevelopers < ActiveRecord::Migration
  def change
    add_column :developers, :admin, :boolean, default: false
  end
end
