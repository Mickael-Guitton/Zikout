class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
  has_many :participants
  has_many :events, through: :participants
  has_many :venues, dependent: :destroy
  has_many :messages
  has_many :notifications

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

  def act?
    role == 'act'
  end

  private

  def placeholder_avatar
    unless avatar.attached?
      placeholder_avatar_url = 'https://res.cloudinary.com/dnxamyssu/image/upload/v1724792835/images_v8c6kp.jpg'
      avatar.attach(io: StringIO.new(Cloudinary::Downloader.download(placeholder_avatar_url)), filename: 'avatar-placeholder.jpg', content_type: 'image/jpeg')
    end
  end

  def placeholder_banner
    unless banner.attached?
      placeholder_banner_url = 'https://res.cloudinary.com/dnxamyssu/image/upload/v1724793550/Article-Name-Banner-Placeholder-Image_jh5pvz.jpg'
      banner.attach(io: StringIO.new(Cloudinary::Downloader.download(placeholder_banner_url)), filename: 'banner-placeholder.jpg', content_type: 'image/jpeg')
    end
  end
end
