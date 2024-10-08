class Event < ApplicationRecord
  include PgSearch::Model
  multisearchable against: [:name, :style, :venue_city]

  has_many :participants, dependent: :destroy
  has_many :messages, dependent: :destroy
  has_many :users, through: :participants, dependent: :destroy

  belongs_to :venue

  validates :start_date, presence: true
  validates :end_date, presence: true

  def fr_start_date
    date_str = start_date.to_s
    date_str = date_str.gsub(" UTC", "")
    date_obj = DateTime.strptime(date_str, "%Y-%m-%d %H:%M:%S")
    date_fr = date_obj.strftime("%a %-d %B %Y à %H:%M")
    jour_fr = {
      "Mon" => "Lundi",
      "Tue" => "Mardi",
      "Wed" => "Mercredi",
      "Thu" => "Jeudi",
      "Fri" => "Vendredi",
      "Sat" => "Samedi",
      "Sun" => "Dimanche"
    }
    jour_fr.each do |eng, fr|
      date_fr.gsub!(eng, fr)
    end

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
    mois_fr.each do |eng, fr|
      date_fr.gsub!(eng, fr)
    end
    return date_fr

  end

  def fr_end_date
    date_str = end_date.to_s
    date_str = date_str.gsub(" UTC", "")
    date_obj = DateTime.strptime(date_str, "%Y-%m-%d %H:%M:%S")
    date_fr = date_obj.strftime("%a %-d %B %Y à %H:%M")
    jour_fr = {
      "Mon" => "Lundi",
      "Tue" => "Mardi",
      "Wed" => "Mercredi",
      "Thu" => "Jeudi",
      "Fri" => "Vendredi",
      "Sat" => "Samedi",
      "Sun" => "Dimanche"
    }
    jour_fr.each do |eng, fr|
      date_fr.gsub!(eng, fr)
    end

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
    mois_fr.each do |eng, fr|
      date_fr.gsub!(eng, fr)
    end
    return date_fr
  end

  private

  def venue_city
    venue.try(:city)

  end
end
