require 'test_helper'


class Api::V1::LocationsControllerTest < ActionController::TestCase


  def setup
    @location = locations(:hbg)
    @api_key = user_applications(:one).api_key
  end

  test "should list races" do
    assert_routing '/api/v1/locations', { controller: 'api/v1/locations', action: 'index'}
    get :index , {format: :json, api_key: @api_key } # check that the action exists
    assert_response :success
    assert_not_nil assigns(:locations) # check that we assigns @locations
    assert_equal assigns(:locations).second.city, @location.city # check some data, controlled by fixures
  end

  test "route to specific location should work" do
    assert_routing "api/v1/locations/1", { controller: "api/v1/locations", action: "show", id: '1'}  #check the route
  end

  test "should return 404 and error message as JSON if race not found" do
    # Try to get location that doesn't exist.
    get :show, { id: 454564654, format: "json", api_key: @api_key }
    assert_response :not_found
    error = JSON.parse(response.body)
    assert_equal error["error_message"], "Resource not found."
  end

  # test "should return 404 and error message as XML if location not found" do
  #   # Try to get location that don't exist.
  #   get :show, { id: 454564654, format: "xml" }
  #   assert_response :not_found
  #
  #   # Response in header should be xml.
  #   assert_equal @response.headers['Content-Type'], 'application/xml; charset=utf-8'
  #
  #   # assert_select is often used for HTML but works great for XML
  #   assert_select 'developerMessage', 1
  #   assert_select 'userMessage', 1
  # end

  test "should return 400 and error message if wrong format is requested" do
    get :show , {id: @location.id, format: "html", api_key: @api_key } # Api doesn't support html.
    assert_response :bad_request
    assert_equal @response.headers['Content-Type'], 'application/json; charset=utf-8'
    error = JSON.parse(response.body)
    assert_equal error["error_message"], "The API does not support requested format."
  end

  test "should return 401 when providing invalid api-key" do
    get :index , { api_key: "randomstring" }
    assert_response :unauthorized
  end

  test "should return 401 when not providing api-key" do
    get :index
    assert_response :unauthorized
  end

  test "should not be able to create location without valid api_key" do
    post :create, locations: { city: 'Stockholm', format: 'json' }
    assert_response :unauthorized
    assert_equal 'Missing or invalid API-key', JSON.parse(response.body)['error_message']
  end
end
