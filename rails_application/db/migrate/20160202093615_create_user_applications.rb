class CreateUserApplications < ActiveRecord::Migration
  def change
    create_table :user_applications do |t|
      t.string :name
      t.text :description
      t.string :api_key
      t.references :user, index: true, foreign_key: true

      t.timestamps null: false
    end
    add_index :user_applications, :api_key
  end
end
