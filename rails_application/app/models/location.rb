class Location < ActiveRecord::Base
  has_many :races
  validates :city, presence: true, length: { maximum: 100 }

  # Using geocoder to get longtitude and latitude.
  geocoded_by :city
  after_validation :geocode, if: :city_changed?
  # TODO: Kolla att long och lat verkligen har lagts till. 
end
