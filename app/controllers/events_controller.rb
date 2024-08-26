class EventsController < ApplicationController

  before_action :authenticate_user!

  def index
    @events = Event.all.sort_by(&:start_date)
  end

  def show
    @event = Event.find(params[:id])
    @venue = @event.venue
    @participants = Participant.where(event: @event.id)
    @participant_accepted = @participants.where(status: "accepted")
    @participant_pending = @participants.where(status: "pending")
    @participant_declined = @participants.where(status: "declined")
    @already_applied = @participants.exists?(user: current_user)
    @participant = @participants.find_by(user: current_user) if @already_applied
  end

  def create
    @event = Event.new(event_params)
    @event.user = current_user
    if @event.save
      redirect_to event_path(@event)
    else
      redirect_to venue_path(@event.venue), notice: "Event not created"
    end
  end

  def lock_event
    @event = Event.find(params[:id])
    @event.is_locked = true
    @event.save
    redirect_to event_path(@event)
  end

  def destroy
    @event = Event.find(params[:id])
    @event.destroy
    redirect_to events_path
  end

  private

  def event_params
    params.require(:event).permit(:name, :date, :description)
  end
end
