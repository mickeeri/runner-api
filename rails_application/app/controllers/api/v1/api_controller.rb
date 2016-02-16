module Api
  module V1
    class ApiController < ApplicationController
      before_filter :api_key

      private

      # Checks if user has valid api-key
      def api_key
        user_application = UserApplication.find_by_api_key(params[:api_key])
        unless user_application
          render json: { error: "Du saknar eller har en ogitlig API-nyckel. "}, status: :unauthorized
        end
      end

    end
  end
end
