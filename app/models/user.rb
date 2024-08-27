class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
  has_many :participants
  has_many :events, through: :participants
  has_many :venues
  has_many :messages

  has_one_attached :avatar
  has_one_attached :banner

  ROLES = ["tenant", "act"]
  STYLES = ["jazz", "pop-rock", "classical", "folk", "blues", "world", "electronic", "hip-hop", "metal", "reggae", "punk", "soul", "funk", "country", "latin", "other"]
  validates :role, inclusion: { in: ROLES }
  validates :name, presence: true
  validates :city, presence: true

  before_create :placeholder_avatar
  before_create :placeholder_banner

  if :role == "act"
    validates :description, presence: true
    validates :members, presence: true
  end

  def placeholder_avatar
    if avatar.attached?
      avatar
    else
      "app/assets/images/placeholder_avatar.png"
    end
  end

  def placeholder_banner
    if banner.attached?
      banner
    else
      "app/assets/images/placeholder_banner.jpg"
    end
  end
end
