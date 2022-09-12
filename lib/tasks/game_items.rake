# frozen_string_literal: true

namespace :game_items do
  task init: :environment do
    data_path = Rails.root.join('db', 'items.csv')
    CSV.foreach(data_path) do |line|
      item_name = line[0]
      puts "Creating #{item_name}"
      GameItem.create(name: item_name)
    end
    data_path = Rails.root.join('db', 'armor_list.txt')
    CSV.foreach(data_path) do |line|
      item_name = line[0]
      puts "Creating #{item_name}"
      GameItem.create(name: item_name)
    end
  end
end
