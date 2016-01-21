require 'test_helper'

class DevelopersSignupTest < ActionDispatch::IntegrationTest

	test "signup with invalid credentials should not create new developer" do
		# Visit signup path
		get signup_path
		# Post new user and see if number of developers has changed.
		assert_no_difference 'Developer.count' do
			post developers_path, developer: { name: "", email: "dev@invalid", password: "abc", password_confirmation: "ecz" }
		end
		# Check if new action is re-rendered.
		assert_template 'developers/new'
		# Check if there is an error message.
		assert_select "div[id=error_explanation]"
	end

	test "signup with valid credentials should work" do
		  get signup_path
		  assert_difference 'Developer.count', 1 do
		    post_via_redirect developers_path, developer: { name:  "Mikael Eriksson",email: "user@testexample.com",
		    	password: "password", password_confirmation: "password" }
		  end
		  assert_template 'developers/show'
		  # Check if welcome message is present.
		  assert_not flash.empty?
		end
end
