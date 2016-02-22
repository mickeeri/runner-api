class CreateResourceOwners < ActiveRecord::Migration
  def change
    create_table :resource_owners do |t|
      t.string :access_token, index: true, unique: true
      t.references :race, index: true, foreign_key: true
      t.references :location, index: true, foreign_key: true
      t.references :tag, index: true, foreign_key: true

      t.timestamps null: false
    end
  end
end
