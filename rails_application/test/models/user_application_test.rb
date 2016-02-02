require 'test_helper'

class UserApplicationTest < ActiveSupport::TestCase
  def setup
    @user = users(:mikael)
    @application = @user.user_applications.build(name: "my app", description: "lorem ipsum",
      api_key: "random key")
  end

  test "application should be valid" do
    assert @application.valid?
  end

  test "application should not be valid without user id" do
    @application.user_id = nil
    assert_not @application.valid?
  end

  test "should not be valid without name" do
    @application.name = "    "
    assert_not @application.valid?
  end

  test "description should not be more then 250 chars" do
    @application.description = "a" * 251
    assert_not @application.valid?
  end
end
