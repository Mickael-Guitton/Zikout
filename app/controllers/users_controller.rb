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
    if params[:city].present?
      @acts = User.where(role: "act", city: params[:city])
      @tenants = User.where(role: "tenant", city: params[:city])
    end
    if params[:style].present?
      @acts = User.where(role: "act", styles: [params[:style]])
      @tenants = User.where(role: "tenant")
    end
    @acts = User.where(role: "act")
    @tenants = User.where(role: "tenant")
  end

  private

  def user_params
    params.require(:user).permit(:name, :role, :city, :phone, :description, :demands, :members, :styles, :public_email, :inspiration, :website, :yt_links)
  end
end
