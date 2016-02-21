class Race < ActiveRecord::Base
  # Associations
  belongs_to :race_creator
  belongs_to :location
  acts_as_taggable

  # Validation
  validates :race_creator_id, presence: true
  validates :location_id, presence: true
end
