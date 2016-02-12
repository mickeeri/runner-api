class CreateCreators < ActiveRecord::Migration
  def change
    create_table :creators do |t|
      t.string :name
      t.string :email

      t.timestamps null: false
    end
  end
end
