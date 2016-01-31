require 'test_helper'

class UsersSignupTest < ActionDispatch::IntegrationTest

	test "signup with invalid credentials should not create new user" do
		# Visit signup path
		get signup_path
		# Post new user and see if number of users has changed.
		assert_no_difference 'User.count' do
			post users_path, user: { name: "", email: "dev@invalid", password: "abc", password_confirmation: "ecz" }
		end
		# Check if new action is re-rendered.
		assert_template 'users/new'
		# Check if there is an error message.
		assert_select "div[id=error_explanation]"
	end

	test "signup with valid credentials should work" do
		  get signup_path
		  assert_difference 'User.count', 1 do
		    post_via_redirect users_path, user: { name:  "Mikael Eriksson",email: "user@testexample.com",
		    	password: "password", password_confirmation: "password" }
		  end
		  assert_template 'users/show'
			assert is_logged_in?
		  # Check if welcome message is present.
		  assert_not flash.empty?
		end
end
