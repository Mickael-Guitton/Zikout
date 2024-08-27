class Message < ApplicationRecord
  belongs_to :user
  belongs_to :event

  validates :content, presence: true

  after_create_commit :broadcast_message

  private

  def broadcast_message
    broadcast_append_to "event_#{event.id}_messages",
                          partial: "messages/message",
                          locals: { message:self, user: user },
                          target: "messages"
  end
end
