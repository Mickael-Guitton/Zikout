class Participant < ApplicationRecord
  belongs_to :user
  belongs_to :event

  validates :user_id, uniqueness: { scope: :event_id, message: "a déjà été ajouté à cet évènement" }
end
