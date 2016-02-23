module Api
  module V1
    class RacesController < ApiController
      before_action :authenticate, only: [:create, :destroy, :edit]
      before_action :find_race, only: [:show, :destroy, :update]
      before_action :resource_owner?, only: [:edit, :destroy]
      before_action :get_location, only: [:create]

      # TODO: returnerna 403? om inte currrent user?

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
        # empty
      end

      def create
        # Building race without the :city paramater.
        @race = current_user.races.build(race_params.except(:city))
        # Beacuse :city is used for creating/finding location object that is assigned here.
        @race.location = @location
        if @race.save
          respond_with @race, status: :created, template: 'api/v1/races/show'
        else
          render json: { error: "Bad request. Could not create resource. Wrong parameters?"}, status: :bad_request
        end
      end

      def destroy
        @race.destroy
        render json: { message: "Resource destroyed"}, status: :accepted
      end

      def update
        if @race.update_attributes(race_params.except(:city))
          respond_with @race, status: :ok, template: 'api/v1/races/show'
        else
          render json: { message: "Could not edit resource. Wrong parameters?"}, status: :bad_request
        end
      end

      private

      def race_params
        json_params = ActionController::Parameters.new( JSON.parse(request.body.read) )
        json_params.require(:race).permit(:name, :date, :organiser, :web_site, :distance, :tag_list, :city)
      end

      # # Ability to send parameter city.
      # def city_param
      #   json_params = ActionController::Parameters.new( JSON.parse(request.body.read) )
      #   json_params.require(:race).permit(:city)
      # end

      def find_race
        @race = Race.find(params[:id])
      end

      # Checks if person authenticated owns resource.
      def resource_owner?
        race = current_user.races.find_by(id: params[:id])
        render json: { message: "Forbidden. Not resource owner."},
          status: :forbidden if race.nil?
      end

      # Gets location based on paramater city.
      def get_location
        if race_params[:city]
          # Try to find location
          @location = Location.find_by_city(race_params[:city])
          # If it does not exists create it.
          if @location.nil?
            @location = Location.create(city: race_params[:city])
          end
        end
      end

    end
  end
end
