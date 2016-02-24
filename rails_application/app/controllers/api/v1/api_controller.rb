module Api
  module V1
    class ApiController < ApplicationController

      # Knock gem for api authentification.
      include Knock::Authenticable

      # Before actions/filters
      before_filter :api_key
      before_action :offset_params, only: [:index, :nearby]

      # Rescuing errors with private methods.
      rescue_from ActionController::UnknownFormat, with: :raise_bad_format
      rescue_from ActiveRecord::RecordNotFound, with: :raise_not_found
      rescue_from ActionView::MissingTemplate, with: :raise_bad_format

      respond_to :json

      # default offset paramaters.
      OFFSET = 0
      LIMIT = 10

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
          render json: { error_message: "Missing or invalid API-key"}, status: :unauthorized
        end
      end

      # 404 not found
      def raise_not_found
        #@error_message = ErrorMessage.new("Could not find that resource. Are you using the correct location_id?", "Resursen kunde inte hittas.")
        render json: { error_message: "Resource not found."}, status: :not_found
      end

      # Response to wrong format requests.
      def raise_bad_format
        # @error = ErrorMessage.new("The API does not support the requested format?",
        #   "Felaktig förfrågan. Kontakta utvecklare.")
        render json: { error_message: "The API does not support requested format."}, status: :bad_request
      end
    end
  end
end
