# frozen_string_literal: true

FactoryBot.define do
  factory :auction_item do
    game_item
    user
    title do
      quality = %w[Normal Exceptional Elite].sample
      armor_piece = %w[gloves helm chest].sample
      enhanced_defence = rand(5...30)
      "#{quality} #{armor_piece} #{enhanced_defence} ED"
    end
    description { "Looking for #{rand(2...6)} Perfect Gems" }
  end

  factory :moderated_auction_item, parent: :auction_item do
    after(:create) do |object|
      object.moderation_item.approve
    end
  end
end
