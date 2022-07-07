# frozen_string_literal: true

json.array! @auction_offers, partial: 'auction_offers/auction_offer', as: :auction_offer
