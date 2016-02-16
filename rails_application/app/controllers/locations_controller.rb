class LocationsController < ApplicationController
  respond_to :json, :xml

  # Rescuing errors with private methods.
  rescue_from ActionController::UnknownFormat, with: :raise_bad_format
  rescue_from ActiveRecord::RecordNotFound, with: :raise_not_found
  rescue_from ActionView::MissingTemplate, with: :raise_bad_format

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

    location = Location.new(location_params)
    if location.save
      respond_with location, status: :created
    else
      error = ErrorMessage.new("Could not create resource. Bad parameters?", "Kunde inte skapa plats.")
      render json: error, status: :bad_request
    end
  end

  private
  #### Private methods ####

  def location_params
    params.require(:location).permit(:city, :longitude, :latitude)
    # json_params = ActionController::Parameters.new( JSON.parse(request.body.read) )
    # json_params.require(:location).permit(:city, :longitude, :latitude)
  end

  # Raise not found.
  def raise_not_found
    @error = ErrorMessage.new("Could not find that resource. Are you using the correct location_id?", "Resursen kunde inte hittas.")
    render json: @error, status: :not_found
  end

  # Response to wrong format requests.
  def raise_bad_format
    @error = ErrorMessage.new("The API does not support the requested format?",
      "Felaktig förfrågan. Kontakta utvecklare.")
    render json: @error, status: :bad_request
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
