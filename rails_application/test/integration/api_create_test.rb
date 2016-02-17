require 'test_helper'

class ApiCreateTest < ActionDispatch::IntegrationTest
  def setup
    @api_key = user_applications(:one).api_key
  end

  test "should be able to create new location with valid api-key" do

    location_params = {
      "location" => {
        "city" => "Stockholm"
      }
    }.to_json

    request_headers = {
      "Accept" => "application/json",
      "Content-Type" => "application/json"
    }

    assert_difference 'Location.count', 1 do
      post "/api/v1/locations?api_key=#{@api_key}", location_params, request_headers
    end

    # Responser should be 201.
    assert_response :created

    # Check if response is as expected and that coordinate's are set.
    json_expected_response = {
      "city" => "Stockholm",
      "longitude" => 18.0685808,
      "latitude" => 59.3293235
    }.to_json

    assert_equal json_expected_response, response.body
  end

  # test "should be able to create new race with valid api-key" do
  #   assert_difference 'Race.count', 1 do
  #     post "/api/v1/races?api_key=#{@api_key}", race_params, request_headers
  #   end
  # end
end
