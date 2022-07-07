# frozen_string_literal: true

FactoryBot.define do
  factory :auction_offer do
    user
    auction_item
    description { 'MyText' }
  end
end
