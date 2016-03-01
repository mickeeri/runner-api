module Api
  module V1
    class LocationsController < ApiController
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
  end
end
