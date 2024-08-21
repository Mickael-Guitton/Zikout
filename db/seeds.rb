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
User.destroy_all
Venue.destroy_all
Event.destroy_all


puts "Creating fake tenants..."

10.times do
  User.create!(
    role: "tenant",
    email: Faker::Internet.email,
    password: "azerty1234",
    name: Faker::Company.name,
    )
end


puts "Creating fake acts..."

10.times do
  User.create!(
    role: "act",
    email: Faker::Internet.email,
    password: "azerty1234",
    name: Faker::Company.name,
    style: Faker::Music.genre,
    description: Faker::Lorem.paragraph,
    city: Faker::Address.city,
    avatar: Faker::Avatar.image(slug: "my-own-slug"),
    )
end


puts "Creating fake venues..."

tenants = User.where(role: "tenant")
scene = ["small", "medium", "large", "extra-large"]
capacity = (30..500).to_a
paying = ["yes", "no"]


tenants.each do |tenant|
  Venue.create!(
    name: Faker::Company.name,
    address: Faker::Address.full_address,
    description: Faker::Lorem.paragraph,
    lodging: "yes" || "no",
    scene_size: scene.sample,
    paying: paying.sample,
    capacity: capacity.sample,
    user_id: tenant.id,
    )
end


puts "Creating fake events..."

10.times do
  Event.create!(
    name: Faker::Music.album,
    description: Faker::Lorem.paragraph,
    start_date: Faker::Date.between(from: Date.today, to: '2050-09-25'),
    venue_id: Venue.all.sample.id,
    )
end
