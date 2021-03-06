class Api::V1::ApiController < ApplicationController

  # Knock gem for api authentification.
  include Knock::Authenticable

  # Before actions/filters
  before_filter :api_key
  before_action :offset_params, only: [:index, :nearby]
  skip_before_action :verify_authenticity_token

  # Rescuing errors with private methods.
  rescue_from ActionController::UnknownFormat, with: :raise_bad_format
  rescue_from ActiveRecord::RecordNotFound, with: :raise_not_found
  rescue_from ActionView::MissingTemplate, with: :raise_bad_format

  respond_to :json

  # default offset paramaters.
  OFFSET = 0
  LIMIT = 50

  # Check if user wants offset.
  def offset_params
    if params[:offset]
      @offset = params[:offset].to_i
    end
    if params[:limit]
      @limit = params[:limit].to_i
    end
    @offset ||= OFFSET
    @limit  ||= LIMIT
  end

  private

  # Checks if user has valid api-key
  def api_key
    user_application = UserApplication.find_by_api_key(params[:api_key])
    unless user_application
      error_message = ErrorMessage.new('401','Applikationen saknar giltig api-nyckel',
        "Serverfel. Kontakta utvecklare.")
      render json: error_message, status: :unauthorized
    end
  end

  # 404 not found
  def raise_not_found
    error_message = ErrorMessage.new('404', 'Kunde inte hitta resurs. Använder du rätt id?',
      "Resursen du söker finns inte.")
    render json: error_message, status: :not_found
  end

  # Response to wrong format requests.
  def raise_bad_format
    error_message = ErrorMessage.new("400", "Api:et stödjer inte det begärda formatet.",
      "Felaktig begäran. Kontakta utvecklaren.")
    render json: error_message, status: :bad_request
  end

  def authenticate_resource_owner
    # If knock gems current user is not defined the authorization has failed.
    unless current_user
      error_message = ErrorMessage.new('401', 'Autentiserings-token saknas eller är ogiltig.',
        'Autentisering misslyckades.')
      render json: error_message, status: :unauthorized
      return false
    end
  end

  # Check if authenticated user is owner of this resource.
  def resource_owner?
    race = current_user.races.find_by(id: params[:id])
    if race.nil?
      error_message = ErrorMessage.new('403', 'Användaren är inte resursens ägare.',
        "Kan bara utföras av den som skapade resursen.")
      render json: error_message, status: :forbidden
    end
  end
end
