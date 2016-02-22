class CreateRaces < ActiveRecord::Migration
  def change
    create_table :races do |t|
      t.string :name, index: true
      t.date :date
      t.string :organiser
      t.string :web_site
      t.float :distance
      t.references :location, index: true, foreign_key: true

      t.timestamps null: false
    end
  end
end
