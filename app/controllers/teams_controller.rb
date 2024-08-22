class TeamsController < ApplicationController
  def create
    @event = Event.find(params[:event_id])
    @team = Team.new(user: current_user, event: @event)

    if @team.save
      redirect_to event_path(@event), notice: "Vous avez bien postulé à cet event !"
    else
      redirect_to event_path(@event), notice: "Il y a eu un problème. Réessayez plus tard."
    end
  end
end
