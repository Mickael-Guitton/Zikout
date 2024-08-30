# This file should ensure the existence of records required to run the application in every environment (production,
# development, test). The code here should be idempotent so that it can be executed at any point in every environment.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Example:
#
#   ["Action", "Comedy", "Drama", "Horror"].each do |genre_name|
#     MovieGenre.find_or_create_by!(name: genre_name)
#   end
require 'faker'

puts "Cleaning database..."
Event.destroy_all
Venue.destroy_all
User.destroy_all

puts "Creating fake tenants..."

10.times do
  User.create!(
    role: "tenant",
    email: Faker::Internet.email,
    password: "azerty1234",
    name: Faker::Company.name,
    city: Faker::Address.city,
  )
end

puts "Creating fake acts..."


10.times do
  file = URI.open(Faker::Avatar.image(slug: "my-own-slug"))
  user = User.new(
    role: "act",
    email: Faker::Internet.email,
    password: "azerty1234",
    name: Faker::Company.name,
    demands: User::DEMANDS.sample,
    description: Faker::Lorem.paragraph,
    city: Faker::Address.city
  )
  user.avatar.attach(io: file, filename: 'avatar.jpg', content_type: 'image/jpg')
  user.save
end


puts "Creating fake members..."
instruments = ["guitare", "basse", "batterie", "chant", "clavier", "saxophone", "trompette", "trombone", "violon", "violoncelle", "flûte", "clarinette", "harpe", "accordéon", "banjo", "mandoline", "harmonica", "percussions"]

acts = User.where(role: "act")
acts.each do |act|
  3.times do
    Member.create!(
      nickname: Faker::Name.first_name,
      instrument: instruments.sample,
      user_id: act.id
    )
  end
end

User.all.each do |user|
  3.times do
    Style.create!(content: Style::CONTENTS.sample, user_id: user.id)
  end
end

puts "Creating fake venues..."

tenants = User.where(role: "tenant")
scene = ["très petite - 2m² à 6m²", "petite - 7m² à 14m²", "moyenne - 15m² à 24m²", "grande - 25m² à 35m²", "très grande - 36m² et plus"]
capacity = (30..500).to_a
paying = ["oui", "non"]

tenants.each do |tenant|
  Venue.create!(
    name: Faker::Company.name,
    street: Faker::Address.street_address,
    city: Faker::Address.city,
    zipcode: Faker::Address.zip_code,
    country: Faker::Address.country,
    description: Faker::Lorem.paragraph,
    category: Venue::CATEGORIES.sample,
    lodging: "oui" || "non",
    scene_size: scene.sample,
    paying: paying.sample,
    capacity: capacity.sample,
    user_id: tenant.id
  )
end

puts "Creating fake events..."
venues = Venue.all
styles = ["jazz", "pop-rock", "classique", "folk", "blues", "electronic", "hip-hop", "metal", "reggae", "punk", "soul", "funk", "country", "latin", "other"]
venues.each do |venue|
  Event.create!(
    name: Faker::Music.album,
    description: Faker::Lorem.paragraph,
    start_date: Faker::Date.between(from: Date.today, to: '2050-09-25'),
    end_date: Faker::Date.between(from: Date.today, to: '2050-09-25'),
    venue_id: venue.id,
    style: styles.sample
  )
end
