class VenuesController < ApplicationController
  def index
    @venues = Venue.all
  end

  def show
    @venue = Venue.find(params[:id])
    @new_event = Event.new
    @events = @venue.events
  end
end
