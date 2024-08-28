class EventsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_venue, only: %i[new create]

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
    @messages = Message.where(event: @event.id).sort_by(&:created_at)
    @message = Message.new
  end

  def create
    @event = @venue.events.new(event_params)
    if @event.save
      redirect_to @venue, notice: "L'évèvement a bien été créé"
    else
      redirect_to venue_path(@event.venue), notice: "Event not created"
    end
  end

  def lock_event
    @event = Event.find(params[:id])
    @event.update!(is_locked: true)
    redirect_to event_path(@event)
  end

  def destroy
    @event = Event.find(params[:id])
    @event.destroy
    redirect_to events_path
  end

  private

  def set_venue
    @venue = Venue.find(params[:venue_id])
  end

  def event_params
    params.require(:event).permit(:id, :name, :description, :number_of_acts, :venue_id, :style, :start_date, :end_date)
  end
end
