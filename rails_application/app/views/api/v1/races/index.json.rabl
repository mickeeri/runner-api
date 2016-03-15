object false;

node (:races) do
  partial "api/v1/races/show", object: @races
end

node(:limit) {@limit}
node(:offset) {@offset}


if @races.count(:all) == @limit
  node :next_offset do
    @limit + @offset
  end
end

if @offset > 0
  node :previous_offset do
    @offset - @limit
  end
end

node(:tags) { ActsAsTaggableOn::Tag.all }
