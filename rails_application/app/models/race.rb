class Race < ActiveRecord::Base
  # Associations
  belongs_to :resource_owner
  has_one :location
  acts_as_taggable

  # Validation
  validates :race_creator_id, presence: true
  validates :location_id, presence: true
end
