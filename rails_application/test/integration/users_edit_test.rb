require 'test_helper'

class UsersEditTest < ActionDispatch::IntegrationTest
  def setup
    @user = users(:mikael)
  end


  test "edit with invalid information should fail" do
    log_in_as(@user)
    get edit_user_path(@user)
    assert_template 'users/edit'
    patch user_path(@user), user: { name:  "",email: "mail@invalid",password: "hejsan",password_confirmation: "hopp" }
    assert_template 'users/edit'
  end

  test "edit with valid credentials should succeed" do
    get edit_user_path(@user)
    log_in_as(@user)
    # Friendly forwarding.
    assert_redirected_to edit_user_path(@user)
    #assert_template 'users/edit'
    name  = "Exempel Exempelsson"
    email = "mail@hotmail.com"
    patch user_path(@user), user: { name:  name,
                                    email: email,
                                    password:              "",
                                    password_confirmation: "" }
    assert_not flash.empty?
    assert_redirected_to @user
    @user.reload
    assert_equal name,  @user.name
    assert_equal email, @user.email
    assert session[:forwarding_url] == nil
  end
end
