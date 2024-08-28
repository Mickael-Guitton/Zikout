class Notification < ApplicationRecord
  belongs_to :user
  belongs_to :event

  scope :unread, -> { where(read: false) }

  def mark_as_read!
    update(read: true)
  end
end
