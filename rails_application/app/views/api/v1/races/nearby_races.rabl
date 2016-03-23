object @nearby_race
attributes :name
node(:self_path) { |nearby_race| "race/#{nearby_race.id}" }
node(:self_url) { |nearby_race| api_v1_race_url(nearby_race) }
