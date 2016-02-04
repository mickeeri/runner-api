require 'test_helper'

class UsersControllerTest < ActionController::TestCase

  def setup
    @user = users(:mikael)
    @other_user = users(:kalle)
    @admin = users(:admin)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should not be able to access edit when not logged in" do
    get :edit, id: @user
    assert_not flash.empty?
    assert_redirected_to login_url
  end

  test "should redirect update if not logged in" do
    patch :update, id: @user, user: { name: @user.name, email: @user.email }
    assert_not flash.empty?
    assert_redirected_to login_url
  end

  test "should not be able to access edit when logged in as wrong user" do
    log_in_as(@other_user)
    get :edit, id: @user
    assert flash.empty?
    assert_redirected_to root_url
  end

  test "should not reach update as wrong user" do
    log_in_as(@other_user)
    patch :update, id: @user, user: { name: @user.name, email: @user.email }
    assert flash.empty?
    assert_redirected_to root_url
  end

  test "should not access destroy when not logged in" do
    assert_no_difference 'User.count' do
      delete :destroy, id: @admin
    end
    assert_redirected_to login_url
  end

  test "should not be able to access index if not admin" do
    log_in_as(@other_user)
    assert_not @other_user.admin?
    get :index
    assert_redirected_to root_url
  end

  test "should not be able to access destroy action if logged in as non-admin" do
    log_in_as(@other_user)
    assert_not @other_user.admin?
    assert_no_difference 'User.count' do
      delete :destroy, id: @user
    end
    assert_redirected_to root_url
  end

  test "should not be able to edit admin attribute via web" do
    log_in_as(@other_user)
    assert_not @other_user.admin?
    patch :update, id: @other_user, user: { admin: true }
    assert_not @other_user.admin?
  end
end
