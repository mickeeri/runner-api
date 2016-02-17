class CreateUserApplications < ActiveRecord::Migration
  def change
    create_table :user_applications do |t|
      t.string :name
      t.text :description
      t.string :api_key, index: true, unique: true
      t.references :user, index: true, foreign_key: true

      t.timestamps null: false
    end
  end
end
