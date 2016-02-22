module Api
  module V1
    class LocationsController < ApiController
      # GET api/v1/locations
      def index
        @locations = Location.limit(@limit).offset(@offset)
      end

      # Get api/v1/locations/:id
      def show
        @location = Location.find(params[:id])
      end

      # POST api/v1/locations
      def create
        @location = Location.new(location_params)
        if @location.save
          respond_with @location, status: :created, template: 'api/v1/locations/show'
        else
          # @error = ErrorMessage.new("Could not create resource. Bad parameters?", "Kunde inte skapa plats.")
          render json: { error: "Bad request. Could not create resource."}, status: :bad_request, template: 'api/v1/error'
        end
      end

    private

      def location_params
        #params.require(:location).permit(:city, :longitude, :latitude)
        json_params = ActionController::Parameters.new( JSON.parse(request.body.read) )
        json_params.require(:location).permit(:city, :longitude, :latitude)
      end
    end

    # This is a custom class for handling errors
    class ErrorMessage
      def initialize(dev_mess, usr_mess)
        # This is going to be json...camelcase
        @developerMessage = dev_mess
        @userMessage = usr_mess
      end

      # This is a custom class so we dont have the xml serializer included.
      # I wrote an own to_xml (will be called by framework)
      # There is probably a gem for that!?!
      # def to_xml(options={})
      #   str = "<error>"
      #   str += "  <developerMessage>#{@developerMessage}</developerMessage>"
      #   str += "  <userMessage>#{@userMessage}</userMessage>"
      #   str += "</error>"
      # end
    end
  end
end
