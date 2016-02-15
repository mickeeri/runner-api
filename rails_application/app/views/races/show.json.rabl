object @race
attributes :name, :date, :oragniser, :web_site, :distance, :created_at

node(:index_url) { races_url }

child :location do
  attributes :city
  node(:location_url) { |location| location_url(location) }
end
