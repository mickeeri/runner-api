require 'test_helper'

class StaticPagesControllerTest < ActionController::TestCase

	def setup
		@base_title = "Registeringsapplikation"
	end

  test "should get home" do
    get :home
    assert_response :success
    assert_select "title, #{@base_title}"
  end
end
