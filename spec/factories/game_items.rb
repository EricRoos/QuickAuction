# frozen_string_literal: true

FactoryBot.define do
  factory :game_item do
    sequence(:name, begin
      (GameItem.count + 1)
    rescue StandardError
      1
    end) { |n| "game_item_#{n}" }
  end
end
