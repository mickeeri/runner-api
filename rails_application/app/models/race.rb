class Race < ActiveRecord::Base
  belongs_to :resource_owner
  belongs_to :location
  acts_as_taggable

  validates :name, presence: true, length: { maximum: 150 }
  # TODO: validate date.
  validates :date, presence: true
  validates :organiser, length: { maximum: 150 }
  validates :web_site, length: { maximum: 255 }
  validates :distance, presence: true, numericality: { greater_than: 0 }
  validates :location_id, presence: true
  validates :resource_owner_id, presence: true
end
