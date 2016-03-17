class Api::V1::RacesController < Api::V1::ApiController
  before_action :authenticate_resource_owner, only: [:create, :destroy, :update]
  before_action :find_race, only: [:show, :destroy, :update]
  before_action :resource_owner?, only: [:update, :destroy]
  before_action :get_location, only: [:create]

  # GET /races
  def index
    # Search
    if params[:q]
      @races = Race.where('name LIKE ?', "%#{params[:q]}%")
    # Find races near location.
    elsif params[:near]
      locations_ids = []
      Location.near(params[:near], 20).each do |location|
        locations_ids.push(location.id)
      end
      @races = Race.where("location_id IN (?)", locations_ids)
    end
    # Search with tag.
    if params[:tags]
      tags = params[:tags].split('+')
      # Is @races defined in some of the other if-statements?
      if @races.nil?
        @races = Race.tagged_with(tags)
      else
        @races = @races.tagged_with(tags)
      end
    elsif params[:q].nil?
      @races = Race.all
    end
    # Sorting and limiting.

    @races = @races.order('date ASC').limit(@limit).offset(@offset)
  end

  # Get /races/:id
  def show
    # empty
  end

  def create
    # Building race without the :city paramater.
    @race = current_user.races.build(race_params.except(:city))
    # Using parameter city to assign location in this controller.
    @race.location = @location
    if @race.save
      respond_with @race, status: :created, template: 'api/v1/races/show'
    else
      error_message = ErrorMessage.new('400', 'Kunde inte skapa resurs. Felaktiga parametrar?',
        @race.errors.full_messages.first)
      render json: error_message, status: :bad_request
    end
  end

  def destroy
    @race.destroy
    render json: { success: "#{@race.name} raderad"}, status: :accepted
  end

  def update
    # If user has submitted city param, update location.
    if race_params[:city]
      get_location
      @race.location = @location
    end
    if @race.update_attributes(race_params.except(:city))
      respond_with @race, status: :ok, template: 'api/v1/races/show'
    else
      error_message = ErrorMessage.new('400', 'Kunde inte uppdatera resurs. Felaktiga parametrar.',
        @race.errors.full_messages.first)
      render json: error_message, status: :bad_request
    end
  end

  private

  def race_params
    json_params = ActionController::Parameters.new( JSON.parse(request.body.read) )
    json_params.permit(:name, :date, :organiser, :web_site, :distance, :tag_list, :city)
  end

  def find_race
    @race = Race.find(params[:id])
  end

  # Gets location based on paramater city.
  def get_location
    # Try to find location
    @location = Location.find_by_city(race_params[:city])
    # If it does not exists create it.
    if @location.nil?
      @location = Location.new(city: race_params[:city])
      unless @location.save
        error_message = ErrorMessage.new('400', 'Kunde inte skapa resurs.',
          @location.errors.full_messages.first)
        render json: error_message, status: :bad_request
      end
    end
  end
end
