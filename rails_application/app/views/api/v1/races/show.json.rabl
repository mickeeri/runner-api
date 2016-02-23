object @race
attributes :name, :date, :oragniser, :web_site, :distance, :created_at

child(:tags) { attributes :name }

child :location do
  attributes :city, :longitude, :latitude
  node(:location_url) { |location| api_v1_location_url(location) }
end
