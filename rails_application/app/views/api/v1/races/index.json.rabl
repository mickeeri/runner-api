collection @races
extends "api/v1/races/show"

if @races.count(:all) == @limit
  node(:next_page){ api_v1_races_url(limit: @limit, offset: @limit + @offset) }
end

if @offset > 0
  node(:previous_page){ api_v1_races_url(limit: @limit, offset: @offset - @limit) }
end
