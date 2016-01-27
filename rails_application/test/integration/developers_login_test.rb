require 'test_helper'

class DevelopersLoginTest < ActionDispatch::IntegrationTest

  def setup
    @developer = developers(:mikael)
  end

  test "login with invalid information should show error message" do
    # Visit login path
    get login_path
    # Validate that form renders
    assert_template 'sessions/new'
    # Post invalid params
    post login_path, session: { email: "", password: "" }
    # Assert that form gets re-rendered and error message appears.
    assert_template 'sessions/new'
    assert_not flash[:danger].empty?
    # Check that error message disappears when visiting other page.
    get root_path
    assert flash.empty?
  end

  test "login with valid information followed by logout" do
    get login_path
    post login_path, session: { email: @developer.email, password: 'password' }
    assert_redirected_to root_path
    follow_redirect!
    assert_template 'static_pages/home'
    assert_not flash[:success].empty?
    # Check links.
    assert_select "a[href=?]", login_path, count: 0
    assert_select "a[href=?]", logout_path
    assert_select "a[href=?]", developer_path(@developer)
    # Logout
    delete logout_path
    assert_not is_logged_in?
    assert_redirected_to root_url
    follow_redirect!
    assert_select "a[href=?]", login_path
    assert_select "a[href=?]", logout_path,      count: 0
    assert_select "a[href=?]", developer_path(@developer), count: 0
  end
end
