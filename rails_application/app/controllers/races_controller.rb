class RacesController < ApplicationController

  # Error handling
  rescue_from ActionController::UnknownFormat, with: :raise_bad_format
  rescue_from ActiveRecord::RecordNotFound, with: :raise_not_found
  rescue_from ActionView::MissingTemplate, with: :raise_bad_format

  def index
    @races = Race.all
    #respond_with @races, satus: :ok, location: races_path
  end

  def show
    @race = Race.find(params[:id])
    #respond_with @race, location: races_path(@race)
  end

  private
  #### Private methods ####

  # Response to RecordNotFound error.
  def raise_not_found
    @error = ErrorMessage.new("Could not find that resource. Are you using the correct race_id?", "Resursen kunde inte hittas.")
    render json:  @error, status: :not_found
  end

  # Response to wrong format requests.
  def raise_bad_format
    @error = ErrorMessage.new("The API does not support the requested format?",
      "Felaktig förfrågan. Kontakta utvecklare.")
    render json: @error, status: :bad_request
  end
end

# TODO: Move to own file.
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
