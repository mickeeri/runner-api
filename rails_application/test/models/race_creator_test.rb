require 'test_helper'

class RaceCreatorTest < ActiveSupport::TestCase

  def setup
    @race_creator = race_creators(:one)
  end

  test "race creator should be valid" do
    assert @race_creator.valid?
  end
end
