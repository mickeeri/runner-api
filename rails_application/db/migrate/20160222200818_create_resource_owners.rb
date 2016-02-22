class CreateResourceOwners < ActiveRecord::Migration
  def change
    create_table :resource_owners do |t|
      t.string :access_token

      t.timestamps null: false
    end
  end
end
