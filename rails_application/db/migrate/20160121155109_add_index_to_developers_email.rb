class AddIndexToDevelopersEmail < ActiveRecord::Migration
  def change
  	add_index :developers, :email, unique: true
  end
end
