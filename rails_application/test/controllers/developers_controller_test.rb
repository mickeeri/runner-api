require 'test_helper'

class DevelopersControllerTest < ActionController::TestCase

  def setup
    @developer = developers(:mikael)
    @other_developer = developers(:kalle)
    @admin = developers(:admin)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  # test "should redirect index if not logged in" do
  #   get :index
  #   assert_redirected_to login_url
  # end

  test "should not be able to access edit when not logged in" do
    get :edit, id: @developer
    assert_not flash.empty?
    assert_redirected_to login_url
  end

  test "should redirect update if not logged in" do
    patch :update, id: @developer, developer: { name: @developer.name, email: @developer.email }
    assert_not flash.empty?
    assert_redirected_to login_url
  end

  test "should not be able to access edit when logged in as wrong user" do
    log_in_as(@other_developer)
    get :edit, id: @developer
    assert flash.empty?
    assert_redirected_to root_url
  end

  test "should not reach update as wrong user" do
    log_in_as(@other_developer)
    patch :update, id: @developer, developer: { name: @developer.name, email: @developer.email }
    assert flash.empty?
    assert_redirected_to root_url
  end

  test "should not access destroy when not logged in" do
    assert_no_difference 'Developer.count' do
      delete :destroy, id: @admin
    end
    assert_redirected_to login_url
  end

  test "should not be able to access index it not admin" do
    log_in_as(@other_developer)
    get :index
    assert_redirected_to root_url
  end

  test "should not be able to access destroy action if logged in as non-admin" do
    log_in_as(@other_developer)
    assert_no_difference 'Developer.count' do
      delete :destroy, id: @developer
    end
    assert_redirected_to root_url
  end

  test "should not be able to edit admin attrubute via web" do
    log_in_as(@other_developer)
    assert_not @other_developer.admin?
    patch :update, id: @other_developer, developer: { admin: true }
    assert_not @other_developer.admin?
  end
end
