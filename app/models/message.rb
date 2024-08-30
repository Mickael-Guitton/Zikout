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

  def formatted_created_at
    # Dictionnaires pour la traduction
    jours_fr = {
      "Monday" => "Lundi",
      "Tuesday" => "Mardi",
      "Wednesday" => "Mercredi",
      "Thursday" => "Jeudi",
      "Friday" => "Vendredi",
      "Saturday" => "Samedi",
      "Sunday" => "Dimanche"
    }

    mois_fr = {
      "January" => "Janvier",
      "February" => "Février",
      "March" => "Mars",
      "April" => "Avril",
      "May" => "Mai",
      "June" => "Juin",
      "July" => "Juillet",
      "August" => "Août",
      "September" => "Septembre",
      "October" => "Octobre",
      "November" => "Novembre",
      "December" => "Décembre"
    }

    # Formatter la date en anglais
    date_fr = created_at.strftime("%A %-d %B %Y à %H:%M")

    # Remplacer les jours et mois par leurs équivalents français
    jours_fr.each { |eng, fr| date_fr.gsub!(eng, fr) }
    mois_fr.each { |eng, fr| date_fr.gsub!(eng, fr) }

    date_fr
  end

  private

  def broadcast_message
    broadcast_append_to "event_#{event.id}_messages",
                          partial: "messages/message",
                          locals: { message:self, user: user },
                          target: "messages"
  end
end
