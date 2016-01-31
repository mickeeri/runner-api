require 'test_helper'


class SiteLayoutTest < ActionDispatch::IntegrationTest

	# Test that layout view displays required links.
	test "layout links" do
		get root_path
		assert_template 'static_pages/home'
    assert_select "a[href=?]", root_path, count: 2
    assert_select "a[href=?]", help_path
    assert_select "a[href=?]", about_path
    get signup_path "title", full_title("Sign up")
	end
end