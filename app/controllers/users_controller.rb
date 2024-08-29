class UsersController < ApplicationController
  def profile
    @user = current_user
    if @user.role == "tenant"
      @venue = Venue.new
      @venues = Venue.where(user_id: current_user.id)
      @events = Event.where(venue_id: @venues.ids)
    elsif @user.role == "act"
      @events = current_user.events.where(is_locked: true)
      @member = Member.new
      @style = Style.new
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
    @acts = User.where(role: "act")
    @tenants = User.where(role: "tenant")
  end

  private

  def set_styles
    @styles = Style.where(user_id: current_user.id).join(", ")
  end

  def user_params
    params.require(:user).permit(:name, :role, :city, :phone, :description, :demands, :members, :styles, :public_email, :inspiration, :website, :yt_links)
  end
end
