class Venue < ApplicationRecord

  include PgSearch::Model
  multisearchable against: [:name, :city, :category]

  belongs_to :user
  has_many :events

  validates :name, presence: true
  validates :street, presence: true
  validates :city, presence: true
  validates :zipcode, presence: true
  validates :country, presence: true
  validates :description, presence: true
  CATEGORIES = ["Bar", "Club", "Restaurant", "Salle de Spectacle", "Salle Polyvalente", "Théâtre", "Festival", "Other"]
  validates :category, presence: true, inclusion: { in: CATEGORIES }
  validates :capacity, presence: true
  validates :scene_size, presence: true
  validates :lodging, presence: true
  validates :paying, presence: true

  def introduce
    case self.name[0].downcase
    when "la"
      return "À #{name}"
    when "les"
      return "Aux #{name}"
    else
      return "Au #{name}"
    end
  end

  def full_address
    "#{street}, #{city}, #{zipcode} #{country}"
  end
end
