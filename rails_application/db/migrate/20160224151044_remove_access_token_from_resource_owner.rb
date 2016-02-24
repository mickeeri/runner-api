class RemoveAccessTokenFromResourceOwner < ActiveRecord::Migration
  def change
    remove_column :resource_owners, :access_token
  end
end
