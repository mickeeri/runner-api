class RenameUsersToDevelopers < ActiveRecord::Migration
  def change
  	rename_table :users, :developers
  end
end
