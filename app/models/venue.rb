class Venue < ApplicationRecord
  belongs_to :user

  validates :name, presence: true
  validates :address, presence: true
  validates :description, presence: true
  validates :capacity, presence: true
  validates :scene_size, presence: true
  validates :lodging, presence: true
  validates :paying, presence: true
end
