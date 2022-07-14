# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: "Star Wars" }, { name: "Lord of the Rings" }])
#   Character.create(name: "Luke", movie: movies.first)
#

5.times do
  FactoryBot.create(:user)
end

require 'csv'

CSV.foreach('db/items.csv') do |row|
  item_name = row[0]

  num_items = rand(0...3)
  num_items.times do
    num_offers = rand(0...6)
    puts "Seeding auctions for '#{item_name}' with '#{num_offers}' offers"
    item = FactoryBot.create(:auction_item, title: item_name)
    num_offers.times do
      FactoryBot.create(:auction_offer, auction_item: item)
    end
  end
end
