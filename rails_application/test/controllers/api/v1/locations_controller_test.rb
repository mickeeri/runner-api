require 'test_helper'


class Api::V1::LocationsControllerTest < ActionController::TestCase


  def setup
    @location = locations(:hbg)
    @api_key = user_applications(:one).api_key
  end

  test "should list locations" do
    assert_routing '/api/v1/locations', { controller: 'api/v1/locations', action: 'index'}
    get :index , {format: :json, api_key: @api_key } # check that the action exists
    assert_response :success
    assert_not_nil assigns(:locations) # check that we assigns @locations
    assert_not_nil assigns(:locations).find_by_city("Stockholm")
    assert_not_nil assigns(:locations).find_by_city("Helsingborg")
    assert_not_nil assigns(:locations).find_by_city("Lund")
  end

  test "route to specific location should work" do
    assert_routing "api/v1/locations/1", { controller: "api/v1/locations", action: "show", id: '1'}  #check the route
  end

  test "should return 404 and error message as JSON if location not found" do
    # Try to get location that doesn't exist.
    get :show, { id: 454564654, format: "json", api_key: @api_key }
    assert_response :not_found
  end

  test "should return 400 and error message if wrong format is requested" do
    get :show , {id: @location.id, format: "html", api_key: @api_key } # Api doesn't support html.
    assert_response :bad_request
    assert_equal @response.headers['Content-Type'], 'application/json; charset=utf-8'
  end

  test "should return 401 when providing invalid api-key" do
    get :index , { api_key: "randomstring" }
    assert_response :unauthorized
  end

  test "should return 401 when not providing api-key" do
    get :index
    assert_response :unauthorized
  end

end
