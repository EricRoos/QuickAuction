# frozen_string_literal: true

json.extract! auction_item, :id, :title, :description, :created_at, :updated_at
json.url auction_item_url(auction_item, format: :json)
