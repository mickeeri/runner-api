class AddResourceOwnerToRace < ActiveRecord::Migration
  def change
    add_reference :races, :resource_owner, index: true, foreign_key: true
  end
end
