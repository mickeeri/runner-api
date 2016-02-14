require 'test_helper'

class LocationsControllerTest < ActionController::TestCase
  def setup
    @location = locations(:helsingborg)
  end


  test "should list races" do
    assert_routing '/locations', { controller: "locations", action: "index"}  #check the route
    get :index , {format: :json} # check that the action exists
    assert_response :success
    assert_not_nil assigns(:locations) # check that we assigns @locations
    assert_equal assigns(:locations).second.city, @location.city # check some data, controlled by fixures
  end

  test "locations/:id should work" do
    assert_routing "locations/1", { controller: "locations", action: "show", id: '1'}  #check the route
  end

  test "should return 404 and error message as JSON if race not found" do
    # Try to get location that doesn't exist.
    get :show, { id: 454564654, format: "json" }
    assert_response :not_found

    # Parse the response.
    error = JSON.parse(response.body)

    # Check that it is correct
    assert_not_nil error["developerMessage"]
    assert_not_nil error["userMessage"]
  end

  test "should return 404 and error message as XML if location not found" do
    # Try to get location that don't exist.
    get :show, { id: 454564654, format: "xml" }
    assert_response :not_found

    # Response in header should be xml.
    assert_equal @response.headers['Content-Type'], 'application/xml; charset=utf-8'

    # assert_select is often used for HTML but works great for XML
    assert_select 'developerMessage', 1
    assert_select 'userMessage', 1
  end

  test "should return 400 and error message if wrong format is requested" do
    get :show , {id: @location.id, format: "html"} # Api doesn't support html.
    assert_response :bad_request
  end
end
