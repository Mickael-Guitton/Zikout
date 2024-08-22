class EventsController < ApplicationController
  before_action :authenticate_user!
  def index
    @events = Event.all
  end

  def show
    @event = Event.find(params[:id])
    @venue = @event.venue
    @teams = Team.where(event: @event.id)
  end
end
