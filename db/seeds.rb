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
require "open-uri"

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
  config.api_key = ENV['POKEMON_API']
end

cards = Pokemon::Card.where(page: 1, pageSize: 1000)
p cards
p cards.count

cards.each do |card|
  file = URI.parse(card.images.large).open
  pokemon = Card.new(title: card.name, description: card.flavor_text, ppd: card.cardmarket.prices.average_sell_price, user: User.all.sample)
  pokemon.photo.attach(io: file, filename: "pokemon_card.png", content_type: "image/png")
  pokemon.save
end

# change index:
# setup Cloudinary and link to API (check doc)
