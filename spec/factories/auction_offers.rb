# frozen_string_literal: true

FactoryBot.define do
  factory :auction_offer do
    user
    auction_item factory: :moderated_auction_item
    description { "#{rand(1...10)} Perfect gems" }
  end

  factory :accepted_auction_offer, parent: :auction_offer do
    after(:create, &:accept)
  end
end
