require 'test_helper'

class ApiCreateTest < ActionDispatch::IntegrationTest

  # def authenticate
  #   token = Knock::AuthToken.new(payload: { sub: resource_owners(:one).id }).token
  #   request.env['HTTP_AUTHORIZATION'] = "Bearer #{token}"
  # end

  def setup
    @api_key = user_applications(:one).api_key
    @resource_owner = resource_owners(:one)
    @jwt = Knock::AuthToken.new(payload: { sub: @resource_owner.id }).token
    @race = races(:springtime)
  end

  # test "should be able to create new location with valid api-key" do
  #
  #   location_params = {
  #     "location" => {
  #       "city" => "Stockholm"
  #     }
  #   }.to_json
  #
  #   request_headers = {
  #     "Accept" => "application/json",
  #     "Content-Type" => "application/json",
  #     "Authorization" => "Bearer #{@jwt}"
  #   }
  #
  #   assert_difference 'Location.count', 1 do
  #     post "/api/v1/locations?api_key=#{@api_key}", location_params, request_headers
  #   end
  #
  #   # Responser should be 201.
  #   assert_response :created
  #
  #   # Check if response is as expected and that coordinate's are set.
  #   json_expected_response = {
  #     "city" => "Stockholm",
  #     "longitude" => 18.0685808,
  #     "latitude" => 59.3293235
  #   }.to_json
  #
  #   assert_equal json_expected_response, response.body
  # end

  test 'crate race with valid api-key and auth-token' do

    request_body = {
      "race" => {
        "name" => "Malmömilen",
        "organiser" => "IFK Malmö",
        "date" => "2016-06-23",
        "web_site" => "http://www.malmomilen.se",
        "distance" => "10",
        "location_id" => "2"
      }
    }.to_json

    request_headers = {
      "Accept" => "application/json",
      "Content-Type" => "application/json",
      "Authorization" => "Bearer #{@jwt}"
    }

    assert_difference 'Race.count', 1 do
      post "/api/v1/races?api_key=#{@api_key}", request_body, request_headers
    end

    # Responser should be 201.
    assert_response :created

    # Check some data from response.
    race = Race.new
    race.from_json(response.body)
    assert_equal race.name, 'Malmömilen'
    assert_equal race.distance, 10
  end

  test 'should be able to edit race' do

    request_body = {
      race: {
        name: 'edited race'
      }
    }.to_json


    request_headers = {
      "Accept" => "application/json",
      "Content-Type" => "application/json",
      "Authorization" => "Bearer #{@jwt}"
    }

    put "/api/v1/races/#{@race.id}?api_key=#{@api_key}", request_body, request_headers

    assert_response :ok

    race = Race.new
    race.from_json(response.body)
    assert_equal race.name, 'edited race'
  end

  test 'should be able to destroy race' do

    request_headers = {
      "Accept" => "application/json",
      "Content-Type" => "application/json",
      "Authorization" => "Bearer #{@jwt}"
    }

    assert_difference 'Race.count', -1 do
      delete "/api/v1/races/#{@race.id}?api_key=#{@api_key}", '', request_headers
    end

    assert_response :accepted
  end


end
