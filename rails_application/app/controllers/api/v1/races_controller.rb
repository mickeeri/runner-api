module Api
  module V1
    class RacesController < ApiController
      # GET /races
      def index
        @races = Race.limit(@limit).offset(@offset)
      end

      # Get /races/:id
      def show
        @race = Race.find(params[:id])
      end
    end
  end
end
