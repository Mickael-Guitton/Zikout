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

styles = ["jazz", "pop-rock", "classical", "folk", "blues", "world", "electronic", "hip-hop", "metal", "reggae", "punk", "soul", "funk", "country", "latin", "other"]

10.times do
    file = URI.open(Faker::Avatar.image(slug: "my-own-slug"))
    user = User.new(
    role: "act",
    email: Faker::Internet.email,
    password: "azerty1234",
    name: Faker::Company.name,
    styles: rand(1..3).times do
              styles.sample
            end,
    description: Faker::Lorem.paragraph,
    city: Faker::Address.city,
  )
  user.avatar.attach(io: file, filename: 'avatar.jpg', content_type: 'image/jpg')
  user.save
end

puts "Creating fake venues..."

tenants = User.where(role: "tenant")
scene = ["very-small", "small", "medium", "large", "extra-large"]
capacity = (30..500).to_a
paying = ["yes", "no"]


tenants.each do |tenant|
  Venue.create!(
    name: Faker::Company.name,
    street: Faker::Address.street_address,
    city: Faker::Address.city,
    zipcode: Faker::Address.zip_code,
    country: Faker::Address.country,
    description: Faker::Lorem.paragraph,
    category: Venue::CATEGORIES.sample,
    lodging: "yes" || "no",
    scene_size: scene.sample,
    paying: paying.sample,
    capacity: capacity.sample,
    user_id: tenant.id
  )
end

puts "Creating fake events..."
venues = Venue.all
categories = ["Bar", "Restaurant", "Club", "Salle de concert", "Salle polyvalente", "Festival"]
venues.each do |venue|
  Event.create!(
    name: Faker::Music.album,
    description: Faker::Lorem.paragraph,
    start_date: Faker::Date.between(from: Date.today, to: '2050-09-25'),
    venue_id: venue.id,
    category: categories.sample
  )
end
