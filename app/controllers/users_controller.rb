class UsersController < ApplicationController
  def profile
    @user = current_user
    if @user.role == "tenant"
      @venue = Venue.new
      @my_venues = Venue.where(user_id: current_user.id)
      @my_events = Event.where(venue_id: @my_venues.ids)
    elsif @user.role == "act"
      @my_events = current_user.events
    end
  end

  def show
    @user = User.find(params[:id])
    if @user.role == "tenant"
      @venues = Venue.where(user_id: @user.id)
      @events = Event.where(venue_id: @venues.ids)
    elsif @user.role == "act"
      @events = @user.events
    end
  end

  def index
    @users = User.all
  end

  private

  def user_params
    params.require(:user).permit(:name, :role, :city, :description, :members, :style, :avatar, :banner)
  end
end
