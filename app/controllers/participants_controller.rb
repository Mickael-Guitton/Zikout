class ParticipantsController < ApplicationController

  before_action :set_event, only: [:create]

  def create
    @event = Event.find(params[:event_id])
    @participant = Participant.new(user: current_user, event: @event)
    if @participant.save
      redirect_to event_path(@event), notice: "Vous avez bien postulé à cet event !"
    else
      redirect_to event_path(@event), notice: "Il y a eu un problème. Réessayez plus tard."
    end
  end

  def destroy
    @participant = Participant.find_by(event_id: params[:event_id], user_id: current_user.id)
    if @participant.destroy
      redirect_to event_path(params[:event_id]), notice: 'Votre candidature a été annulée.'
    else
      redirect_to event_path(params[:event_id]), alert: 'Impossible d\'annuler votre candidature.'
    end
  end

  def accept
    @participant = Participant.find(params[:id])
    @participant.update(status: "accepted")
    redirect_to event_path(@participant.event)
  end

  def set_to_pending
    @participant = Participant.find(params[:id])
    @participant.update(status: "pending")
    redirect_to event_path(@participant.event)
  end

  def decline
    @participant = Participant.find(params[:id])
    @participant.update(status: "declined")
    redirect_to event_path(@participant.event)
  end

  private

  def set_event
    @event = Event.find(params[:event_id])
  end
end
