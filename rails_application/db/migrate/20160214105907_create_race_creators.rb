class CreateRaceCreators < ActiveRecord::Migration
  def change
    create_table :race_creators do |t|
      t.string :name
      t.string :email

      t.timestamps null: false
    end
  end
end
