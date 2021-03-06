require 'test_helper'

class UsersPageTest < ActionDispatch::IntegrationTest
  include ApplicationHelper

  def setup
    @user = users(:pelle)
  end

  test "users page should render correctly" do
    log_in_as(@user)
    get user_path(@user)
  end
end
