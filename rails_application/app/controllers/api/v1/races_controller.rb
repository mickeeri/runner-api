module Api
  module V1
    class RacesController < ApiController
      # GET /races
      def index
        if params[:tag]
          @races = Race.tagged_with(params[:tag]).limit(@limit).offset(@offset)
        else
          @races = Race.limit(@limit).offset(@offset)
        end

      end

      # Get /races/:id
      def show
        @race = Race.find(params[:id])
      end

      def create
        # location =
        # @race = location.races.build(race_params)
      end

      private

      def race_params
        json_params = ActionController::Parameters.new( JSON.parse(request.body.read) )
        json_params.require(:race).permit(:name, :date, :web_site, :distance, :tag_list)
      end

    end
  end
end
