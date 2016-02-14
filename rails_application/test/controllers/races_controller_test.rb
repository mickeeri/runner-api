require 'test_helper'

class RacesControllerTest < ActionController::TestCase
  def setup
    @lidingoloppet = races(:lidingoloppet)
    @springtime = races(:springtime)
  end


  test "should list races" do
    assert_routing '/races', { controller: "races", action: "index"}  #check the route
    get :index , {format: :json} # check that the action exists
    assert_response :success
    assert_not_nil assigns(:races) # check that we assigns @races
    assert_equal assigns(:races).first.name, @lidingoloppet.name # check some data, controlled by fixures
    assert_equal assigns(:races).second.name, @springtime.name
  end

  test "races/:id should work" do
    assert_routing "races/1", { controller: "races", action: "show", id: '1'}  #check the route
  end

  test "should return 404 and error message in JSON if race not found" do
    # Try to get race that don't exist.
    get :show, { id: 454564654, format: "json" }
    assert_response :not_found

    # Parse the response.
    error = JSON.parse(response.body)

    # Check that it is correct
    assert_not_nil error["developerMessage"]
    assert_not_nil error["userMessage"]
  end

  test "should return 404 and error message in XML if race not found" do
    # Try to get race that don't exist.
    get :show, { id: 454564654, format: "xml" }
    assert_response :not_found

    # Response in header should be xml.
    assert_equal @response.headers['Content-Type'], 'application/xml; charset=utf-8'

    # assert_select is often used for HTML but works great for XML
    assert_select 'developerMessage', 1
    assert_select 'userMessage', 1
  end

  test "should return 400 and error message in json if wrong format is requested" do
    get :show ,{:id => "824723", format: "html"} # Api doesn't support html.
    assert_response :bad_request
  end
end
