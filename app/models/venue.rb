class Venue < ApplicationRecord
  include PgSearch::Model
  multisearchable against: [:name, :city, :category]

  belongs_to :user
  has_many :events, dependent: :destroy

  validates :name, presence: true
  validates :street, presence: true
  validates :city, presence: true
  validates :zipcode, presence: true
  COUNTRY = ["France", "Belgique", "Suisse", "Luxembourg", "Canada", "Espagne", "Italie", "Allemagne", "Royaume-Uni", "États-Unis", "Australie", "Japon", "Chine", "Russie", "Brésil", "Argentine", "Autre"]
  validates :country, presence: true
  validates :description, presence: true
  CATEGORIES = ["Bar", "Club", "Restaurant", "Salle de Spectacle", "Salle Polyvalente", "Théâtre", "Festival", "Autre"]
  validates :category, presence: true, inclusion: { in: CATEGORIES }
  validates :capacity, presence: true
  SCENE_SIZE = ["très petite - 2m² à 6m²", "petite - 7m² à 14m²", "moyenne - 15m² à 24m²", "grande - 25m² à 35m²", "très grande - 36m² et plus"]
  validates :scene_size, presence: true
  LODGING = ["OUI", "NON"]
  validates :lodging, presence: true
  PAYING = ["OUI", "NON"]
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
