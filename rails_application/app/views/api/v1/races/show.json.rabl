object @race
attributes :name, :date, :organiser, :web_site, :distance, :created_at

node(:race_details) { |race| "race/#{race.id}" }

child(:tags) { attributes :name }

child :location do
  attributes :city, :longitude, :latitude
  node(:location_url) { |location| api_v1_location_url(location) }
  node(:location_path) { |location| api_v1_location_path(location) }
end
