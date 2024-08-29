class MessagesController < ApplicationController
  before_action :authenticate_user!
  before_action :set_event

  def create
    @message = @event.messages.build(message_params)
    @message.event = @event
    @user = current_user
    @message.user = @user

    if @message.save
        respond_to do |format|
          format.html { redirect_to event_path(@event) }
        end
      end
    else
      render "events/show", status: :unprocessable_entity
    end
  end

  private

  def set_event
    @event = Event.find(params[:event_id])
  end

  def message_params
    params.require(:message).permit(:content)
  end
end
