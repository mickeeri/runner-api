class AddCredentialsToResourceOwner < ActiveRecord::Migration
  def change
    add_column :resource_owners, :screenname, :string
    add_column :resource_owners, :email, :string, index: true
    add_column :resource_owners, :password_digest, :string
  end
end
