class TeamsController < ApplicationController

  before_action :set_event, only: [:create]

  def create
    @team = Team.new(user: current_user, event: @event)

    if @team.save
      redirect_to event_path(@event), notice: "Vous avez bien postulé à cet event !"
    else
      redirect_to event_path(@event), notice: "Il y a eu un problème. Réessayez plus tard."
    end
  end

  def accept
    @team = Team.find(params[:id])
    @team.update(status: "accepted")
    redirect_to event_path(@team.event)
  end

  def set_to_pending
    @team = Team.find(params[:id])
    @team.update(status: "pending")
    redirect_to event_path(@team.event)
  end

  def decline
    @team = Team.find(params[:id])
    @team.update(status: "declined")
    redirect_to event_path(@team.event)
  end

  private

  def set_event
    @event = Event.find(params[:event_id])
  end
end
