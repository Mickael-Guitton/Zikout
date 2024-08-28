class Message < ApplicationRecord
  belongs_to :user
  belongs_to :event

  validates :content, presence: true

  after_create_commit :broadcast_message

  def receivers
    # Get all users associated with the event except the sender
    event_users = event.users.reject { |u| u.id == user_id }

    # Get the event's venue owner
    venue_owner = event.venue.user

    # Combine the event users with the venue owner, ensuring no duplicates
    (event_users + [venue_owner]).uniq
  end

  private

  def broadcast_message
    broadcast_append_to "event_#{event.id}_messages",
                          partial: "messages/message",
                          locals: { message:self, user: user },
                          target: "messages"
  end
end
