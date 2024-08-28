class VenuesController < ApplicationController
  before_action :authenticate_user!
  before_action :set_user, only: %i[create]

  def index
    @venues = Venue.all
  end

  def show
    @venue = Venue.find(params[:id])
    @new_event = Event.new
    @events = @venue.events
  end

  def create
    @venue = Venue.new(venue_params)
    if @venue.save
      redirect_to @venue, notice: "L'établissement a bien été créé"
    else
      redirect_to venue_path, notice: "L'évènement n'a pas été créé"
    end
  end

  private

  def set_user
    @user = User.find(params[:user_id])
  end

  def venue_params
    params.require(:venue).permit(:name, :category, :street, :city, :zipcode, :country, :description, :lodging, :paying, :capacity, :scene_size)
  end
end
