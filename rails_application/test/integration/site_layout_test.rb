require 'test_helper'


class SiteLayoutTest < ActionDispatch::IntegrationTest

	# Test that layout view displays required links.
	test "layout links" do
		get root_path
		assert_template 'static_pages/home'
    assert_select "a[href=?]", root_path, count: 2
    get signup_path "title", full_title("Sign up")
	end
end
