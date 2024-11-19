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
Card.destroy_all

puts 'Creating 5 fake users with 5 fake cards each...'
5.times do
  user = User.new(
    first_name: Faker::Name.first_name,
    last_name: Faker::Name.last_name,
    email: Faker::Internet.email,
    username: Faker::Internet.username,
    password: "account",
    payment_details: Faker::Finance.credit_card
  )
  user.save!
end

User.all.each do |user|
  Card.create!(title: "Pikachu", description: "This Pikachu card is #60/64 from the Jungle set. The card was released on January 16, 1999. The artwork is by Ken Sugimori. The rarity of the card is Common.", ppd: 5, user: user)
  Card.create!(title: "Charizard", description: "This card is in terrible condition, as you can see from the photographs. It appears someone has tried to ‘repair’ this card, by glueing another card on to the back.", ppd: 4, user: user)
end
