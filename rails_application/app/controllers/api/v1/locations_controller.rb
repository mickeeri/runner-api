class Api::V1::LocationsController < Api::V1::ApiController
  before_action :authenticate, only: [:create]
  
  # GET api/v1/locations
  def index
    @locations = Location.limit(@limit).offset(@offset)
  end

  # Get api/v1/locations/:id
  def show
    @location = Location.find(params[:id])
  end
end
