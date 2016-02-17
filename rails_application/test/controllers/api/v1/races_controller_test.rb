require 'test_helper'

class Api::V1::RacesControllerTest < ActionController::TestCase

  def setup
    @lidingoloppet = races(:lidingoloppet)
    @springtime = races(:springtime)
    @api_key = user_applications(:one).api_key
  end

  test "should list races" do
    get :index , { format: :json, api_key: @api_key } # check that the action exists
    assert_response :success
    assert_not_nil assigns(:races) # check that we assigns @races
    assert_equal assigns(:races).first.name, @lidingoloppet.name # check some data, controlled by fixures
    assert_equal assigns(:races).second.name, @springtime.name
  end

  test "route to specifc race should work" do
    assert_routing "api/v1/races/1", { controller: "api/v1/races", action: "show", id: '1'}  #check the route
  end

  test "should return 404 and error message as JSON if race not found" do
    # Try to get race that don't exist.
    get :show, { id: 454564654, format: "json", api_key: @api_key }
    assert_response :not_found
    # Parse the response.
    error = JSON.parse(response.body)
    error = JSON.parse(response.body)
    assert_equal error["error_message"], "Resource not found."
  end

  # TODO: Test for XML.
  # test "should return 404 and error message as XML if race not found" do
  #   # Try to get race that don't exist.
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

  test "should return 400 and error message in json if wrong format is requested" do
    get :show ,{ id: @springtime.id, format: "html", api_key: @api_key } # Api doesn't support html.
    assert_response :bad_request
    assert_equal @response.headers['Content-Type'], 'application/json; charset=utf-8'
    error = JSON.parse(response.body)
    assert_equal error["error_message"], "The API does not support requested format."
  end

  test "should return 401 when providing invalid api-key" do
    get :index , { api_key: "randomstring" }
    assert_response :unauthorized
  end
end
