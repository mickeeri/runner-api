require 'test_helper'

class LocationTest < ActiveSupport::TestCase
  def setup
    @location = locations(:helsingborg)
  end

  test "race creator should be valid" do
    assert @location.valid?
  end
end
