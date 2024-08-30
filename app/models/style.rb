class Style < ApplicationRecord
  belongs_to :user

  validates :content, presence: true

  CONTENTS = ["Jazz", "Pop", "Rock", "Classique", "Folk", "Blues", "Electronic", "Hip-hop", "Metal", "Reggae", "Punk", "Soul", "Funk", "Country", "Latin", "trip-hop"]


end
