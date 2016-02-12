class CreateBridges < ActiveRecord::Migration
  def change
    create_table :bridges do |t|
      t.string :name, index: true
      t.integer :length
      t.text :about
      t.float :latitude
      t.float :longitude
      t.references :creator, index: true, foreign_key: true

      t.timestamps null: false
    end
  end
end
