class EventsController < ApplicationController

  before_action :authenticate_user!
  before_action :set_venue, only: %i[new create]

  def index
    @events = Event.all
  end

  def show
    @event = Event.find(params[:id])
    @venue = @event.venue
    @participants = Participant.where(event: @event.id)
  end

  def create
    @event = @venue.events.new(event_params)
    if @event.save
      redirect_to @venue, notice: "L'évèvement a bien été créé"
    else
      render :new
    end
  end

  private

  def set_venue
    @venue = Venue.find(params[:venue_id])
  end

  def event_params
    params.require(:event).permit(:id, :name, :description, :number_of_acts, :venue_id, :category, :start_date)
  end
end
