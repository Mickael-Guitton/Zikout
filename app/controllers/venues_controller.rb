class VenuesController < ApplicationController
  before_action :authenticate_user!
  before_action :set_user, only: %i[create update]

  def index
    @venues = Venue.all
    @venue = Venue.new
    @user = current_user
  end

  def new
    @user = User.find(params[:user_id])
    @venue = @user.venues.new
    logger.debug "New Venue Initialized: #{@venue.inspect}"
  end

  def show
    @venue = Venue.find(params[:id])
    @new_event = Event.new
    @events = @venue.events
    @user = current_user
  end

  def create
    @user = current_user
    @venue = @user.venues.new(venue_params)
    if @venue.save
      redirect_to @venue, notice: "L'établissement a bien été créé"
    else
      redirect_to user_path(@venue.user), notice: "L'évènement n'a pas été créé"
    end
  end

  def edit
    @user = User.find(params[:user_id])
    @venue = Venue.find(params[:id])
  end

  def update
    @user = current_user
    @venue = @user.venues.find(params[:id])
    if @venue.update(venue_params)
      redirect_to @venue, notice: "L'établissement a bien été mis à jour"
    else
      redirect_to user_path(@venue.user), notice: "L'évènement n'a pas été mis à jour"
    end
  end

  def destroy
    @venue = Venue.find(params[:id])
    @venue.destroy
    redirect_to profile_path, notice: "L'établissement a bien été supprimé"
  end

  private

  def set_user
    @user = User.find(params[:user_id])
  end

  def venue_params
    params.require(:venue).permit(:id, :name, :category, :street, :city, :zipcode, :country, :description, :lodging, :paying, :capacity, :scene_size, :user_id)
  end
end
