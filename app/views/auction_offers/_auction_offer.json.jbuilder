# frozen_string_literal: true

json.extract! auction_offer, :id, :auction_item_id, :description, :created_at, :updated_at
json.url auction_offer_url(auction_offer, format: :json)
