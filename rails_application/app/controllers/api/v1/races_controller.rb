module Api
  module V1
    class RacesController < ApiController
      # GET /races
      def index
        if params[:q]
          @races = Race.where('name LIKE ?', "%#{params[:q]}%")
        elsif params[:tag]
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
        @race = resource_owner.races.build(race_params)
        if @race.save
          respond_with @race, status: :created, template: 'api/v1/races/show'
        else
          render json: { error: "Bad request. Could not create resource. Wrong parameters?"}, status: :bad_request
        end
      end

      private

      def race_params
        json_params = ActionController::Parameters.new( JSON.parse(request.body.read) )
        json_params.require(:race).permit(:name, :date, :organiser, :web_site, :distance, :tag_list, :location_id)
      end
    end
  end
end
