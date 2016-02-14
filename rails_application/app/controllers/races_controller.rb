class RacesController < ApplicationController
  respond_to :xml, :json

  def index
    @races = Race.all
    respond_with(@races)
  end

  def show
    @race = Race.find(params[:id])
    respond_with(@race)
  end
end
