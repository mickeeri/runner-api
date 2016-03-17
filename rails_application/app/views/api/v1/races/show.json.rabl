object @race
attributes :name, :date, :organiser, :web_site, :tag_list, :distance

node(:self_path) { |race| "race/#{race.id}" }
node(:self_url) { |race| api_v1_race_url(race) }
node(:city) { |race| race.location.city }
node(:longitude) { |race| race.location.longitude }
node(:latitude) { |race| race.location.latitude }
