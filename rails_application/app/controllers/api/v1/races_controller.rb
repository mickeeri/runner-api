module Api
  module V1
    class RacesController < ApplicationController
      # GET /races
      def index
        @races = Race.all
      end

      # Get /races/:id
      def show
        @race = Race.find(params[:id])
      end
    end
  end
end
