class Race < ActiveRecord::Base
  # Associations
  belongs_to :resource_owner
  belongs_to :location
  acts_as_taggable

  # Validation
  #validates :race_creator_id, presence: true
  # validates :location_id, presence: true

  #accepts_nested_attributes_for :location
end
