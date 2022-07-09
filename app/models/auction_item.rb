# frozen_string_literal: true

class AuctionItem < ApplicationRecord
  belongs_to :user
  has_many :auction_offers
end
