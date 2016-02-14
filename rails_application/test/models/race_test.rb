require 'test_helper'

class RaceTest < ActiveSupport::TestCase
  def setup
    @race = races(:springtime)
  end

  test "race should be valid" do
    assert @race.valid?
  end
end
