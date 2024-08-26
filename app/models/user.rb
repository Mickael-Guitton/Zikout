class User < ApplicationRecord

  # include PgSearch::Model
  # multisearchable against: [:name, :city]
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
  has_many :participants
  has_many :events, through: :participants
  has_many :venues

  has_one_attached :avatar
  has_one_attached :banner

  ROLES = ["tenant", "act"]
  STYLES = ["jazz", "pop-rock", "classical", "folk", "blues", "world", "electronic", "hip-hop", "metal", "reggae", "punk", "soul", "funk", "country", "latin", "other"]
  validates :role, inclusion: { in: ROLES }
  validates :name, presence: true
  validates :city, presence: true

  if :role == "act"
    validates :description, presence: true
    validates :members, presence: true
  end
end
