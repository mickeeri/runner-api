object @location
attributes :city, :longitude, :latitude

child :races do
  attributes :name
  node(:race_url) { |race| api_v1_race_url(race) }
end
