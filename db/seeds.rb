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
Card.destroy_all
User.destroy_all

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

Pokemon.configure do |config|
  config.api_key = "926278ac-a2fc-49e1-b7a9-8d01c3a520ea"
end

cards = Pokemon::Card.where(page: 1, pageSize: 1000)
p cards
p cards.count


cards.each do |card|
  Card.create!(title: card.name, description: card.flavor_text, ppd: card.cardmarket.prices.average_sell_price, user: User.all.sample)
end

# change index:
# setup Cloudinary and link to API (check doc)
