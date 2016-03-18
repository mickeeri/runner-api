require 'test_helper'

class ApiIntegrationTest < ActionDispatch::IntegrationTest

  def setup
    @api_key = user_applications(:one).api_key
    @jwt = Knock::AuthToken.new(payload: { sub: resource_owners(:one).id }).token
    @other_jwt = Knock::AuthToken.new(payload: { sub: resource_owners(:two).id }).token
    @race = races(:one)
  end

  def request_header(token)
    header = {
      "Accept" => "application/json",
      "Content-Type" => "application/json",
      "Authorization" => "Bearer #{token}"
    }
  end

  test "crate race with valid api-key and auth-token" do

    request_body = {
      name: "Malmömilen",
      organiser: "IFK Malmö",
      date: "2016-06-23",
      web_site: "http://www.malmomilen.se",
      distance: "10",
      city: "Malmö",
      tag_list: "MileN, FolKfest, 10K"
    }.to_json

    assert_difference 'Race.count', 1 do
      race = post "/api/v1/races?api_key=#{@api_key}", request_body, request_header(@jwt)
    end

    # Responser should be 201.
    assert_response :created
    # Check some data in the response.
    parsed_response = JSON.parse(response.body)
    assert_equal 'Malmömilen', parsed_response['name'] #assert_equal(exp, act, msg = nil)
    assert_equal ['milen', 'folkfest', '10k'], parsed_response['tag_list']
    assert_equal 13.003822, parsed_response['longitude']
  end

  test "should not be able to create race without valid token" do

    request_body = {
      race: {
        name: "Malmöloppet",
        organiser: "Malmö IF",
        date: "2016-06-23",
        web_site: "http://www.malmoloppet.se",
        distance: "10",
        city: "Malmö",
        tag_list: "milen, folkfest, 10K"
      }
    }.to_json


    assert_no_difference 'Race.count' do
      race = post "/api/v1/races?api_key=#{@api_key}", request_body, request_header("invalidtoken")
    end

    assert_response :unauthorized
  end

  test "should be able to edit race" do

    request_body = {
      name: 'edited race'
    }.to_json

    put "/api/v1/races/#{@race.id}?api_key=#{@api_key}", request_body, request_header(@jwt)

    assert_response :ok

    parsed_response = JSON.parse(response.body)
    assert_equal 'edited race', parsed_response['name']
  end

  test "should be able to edit race and location" do
    request_body = {
      name: 'edited race',
      city: 'Kalmar'
    }.to_json

    put "/api/v1/races/#{@race.id}?api_key=#{@api_key}", request_body, request_header(@jwt)

    assert_response :ok

    #assert_equal(exp, act, msg = nil)
    parsed_response = JSON.parse(response.body)
    assert_equal 'edited race', parsed_response['name']
    assert_equal 'Kalmar', parsed_response['city']
    assert_equal 16.356779, parsed_response['longitude']
  end

  test "should be able to destroy race" do

    assert_difference 'Race.count', -1 do
      delete "/api/v1/races/#{@race.id}?api_key=#{@api_key}", '', request_header(@jwt)
    end

    assert_response :accepted
  end

  test "should not be possible for other resource owner to destroy resource" do

    assert_no_difference 'Race.count' do
      delete "/api/v1/races/#{@race.id}?api_key=#{@api_key}", '', request_header(@other_jwt)
    end

    assert_response :forbidden
  end

  test "should not be possible to edit resource if not owner" do

    request_body = {
      race: {
        name: 'edited race'
      }
    }.to_json

    put "/api/v1/races/#{@race.id}?api_key=#{@api_key}", request_body, request_header(@other_jwt)

    assert_response :forbidden

    parsed_response = JSON.parse(response.body)
    assert_not_equal 'edited race', parsed_response['name']
  end

  test "should be able to replace tags" do
    # Add some tags to race.
    @race.tag_list.add("vår", "skåne")
    @race.save

    # Add some other tags.
    request_body = {
        tag_list: 'vår, milen'
    }.to_json

    put "/api/v1/races/#{@race.id}?api_key=#{@api_key}", request_body, request_header(@jwt)

    assert_response :ok
    parsed_response = JSON.parse(response.body)
    assert_equal 'vår', parsed_response['tag_list'].first
    assert_equal 'milen', parsed_response['tag_list'].second
  end

  test "should not be able to insert duplicate tags" do
    # Add some tags to race.
    @race.tag_list.add("vår", "vår", "vår", "vår", "skog")
    @race.save
    # Assert that only one entry of duplicates.
    assert_equal ["vår", "skog"], @race.tag_list
  end
end
