require 'test_helper'

class UserApplicationsControllerTest < ActionController::TestCase
  def setup
    @application = user_applications(:one)
    @other_application = user_applications(:two)
    @admin = users(:admin)
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
    #assert_redirected_to root_url
  end

  test "should not be able to destroy wrong application" do
    # Log in as user that don't own any applications.
    log_in_as(users(:kalle))
    application = user_applications(:two)
    assert_no_difference 'UserApplication.count' do
      delete :destroy, id: application
    end
    assert_redirected_to root_url
  end

  test "should not be able to access edit when logged in as wrong user" do
    log_in_as(users(:kalle))
    get :edit, id: @application
    assert flash.empty?
    assert_redirected_to root_url
  end

  test "should not reach update as wrong user" do
    log_in_as(users(:kalle))
    patch :update, id: @application, user_application: { name: "New name", description: "new description" }
    assert flash.empty?
    assert_redirected_to root_url
  end

  test "admin should be able to delete application" do
    log_in_as(@admin)
    assert_difference 'UserApplication.count', -1 do
      delete :destroy, id: @other_application
    end
    #assert_redirected_to
  end

end
