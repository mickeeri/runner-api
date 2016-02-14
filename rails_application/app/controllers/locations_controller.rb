class LocationsController < ApplicationController
  respond_to :xml, :json

  # A better way to catch all the errors - Directing it to a private method
  rescue_from ActiveRecord::RecordNotFound, with: :raise_not_found

  # GET /locations
  def index
    @locations = Location.all
    respond_with @locations, status: :ok, location: locations_path
  end

  # Get /locations/:id
  def show
    @location = Location.find(params[:id])
    respond_with @location, location: locations_path(@location)
    # rescue ActiveRecord::RecordNotFound
    #   # Using a custom error class for handling all my errors
    #   @error = ErrorMessage.new("Could not find that resource. Are you using
    #     the correct location_id?", "Platsen kunde inte hittas.")
    #   # See documentation for diffrent status codes
    #   respond_with  @error, status: :not_found
  end
end

private
  def raise_not_found
    @error = ErrorMessage.new("Could not find that resource. Are you using the correct location_id?", "Platsen kunde inte hittas.")
    #render json: @error, status: :bad_request
    respond_with  @error, status: :not_found
  end

################################### Custom class
# This is a custom class for handling errors - Should be in another file!
# No support from rails base model
class ErrorMessage

  def initialize(dev_mess, usr_mess)
    # This is going to be json...camelcase
    @developerMessage = dev_mess
    @userMessage = usr_mess
  end

  # This is a custom class so we dont have the xml serializer included.
  # I wrote an own to_xml (will be called by framework)
  # There is probably a gem for that!?!
  def to_xml(options={})
    str = "<error>"
    str += "  <developerMessage>#{@developerMessage}</developerMessage>"
    str += "  <userMessage>#{@userMessage}</userMessage>"
    str += "</error>"
  end

end
