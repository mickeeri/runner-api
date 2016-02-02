require 'test_helper'

class UserApplicationsControllerTest < ActionController::TestCase
  def setup
    @application = user_applications(:one)
  end

  test "should redirect create when not logged in" do
    assert_no_difference 'UserApplication.count' do
      post :create, user_application: { name: "min applikation"}
    end
    assert_redirected_to login_url
  end

  test "should redirect destroy if not logged in" do
    assert_no_difference 'UserApplication.count' do
      delete :destroy, id: @application
    end
    assert_redirected_to login_url
  end
end
