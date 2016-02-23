# To not include the root class name in json response.
Rabl.configure do |config|
  config.include_json_root = false
  include_child_root = false
  exclude_nil_values = true
end
