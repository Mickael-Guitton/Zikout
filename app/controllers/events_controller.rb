class EventsController < ApplicationController

  before_action :authenticate_user!

  def index
    @events = Event.all
  end

  def show
    @event = Event.find(params[:id])
    @venue = @event.venue
    @participants = Participant.where(event: @event.id)
  end

  def create
    @event = Event.new(event_params)
    @event.user = current_user
    if @event.save
      redirect_to event_path(@event)
    else

    end
  end

  private

  def event_params
    params.require(:event).permit(:name, :date, :description)
  end
end
