class UsersController < ApplicationController
  def profile
    @user = current_user
    if @user.role == "tenant"
      @my_venues = Venue.where(user_id: current_user.id)
      @my_events = Event.where(venue_id: @my_venues.ids)
    elsif @user.role == "act"
      @my_events = Event.where(user_id: current_user.id)
    end
  end
end
