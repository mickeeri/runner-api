module Api
  module V1
    class LocationsController < ApiController


      # GET /locations
      def index
        @locations = Location.all
      end

      # Get /locations/:id
      def show
        @location = Location.find(params[:id])
      end

      def create
        # This is a POST and should have a body with:
        # { "location":
        #  {
        #    "city": "Stockholm",
        #    "latitude" : "32.324",
        #    "longitude" : "13.3243"
        #   }
        # }

        @location = Location.new(location_params)
        if @location.save
          respond_with @location, status: :created, template: 'api/v1/locations/show'
        else
          # @error = ErrorMessage.new("Could not create resource. Bad parameters?", "Kunde inte skapa plats.")
          # respond_with @error, status: :bad_request, template: 'api/v1/error'
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
