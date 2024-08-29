class Style < ApplicationRecord
  belongs_to :user

  validates :content, presence: true

  CONTENTS = ["Jazz", "Pop", "Rock", "Classical", "Folk", "BBlues", "World", "Electronic", "Hip-hop", "Metal", "Reggae", "Punk", "Soul", "Funk", "Country", "Latin", "Other"]


end
