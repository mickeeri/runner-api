class Location < ActiveRecord::Base
  has_many :races
  validates :city, presence: true

  # Using geocoder to get longtitude and latitude.
  geocoded_by :city
  after_validation :geocode, if: :city_changed?
end
