# frozen_string_literal: true

class AuctionItem < ApplicationRecord
  belongs_to :user
  has_many :auction_offers

  def offer_count
    attributes['offer_count'] || auction_offers.count
  end
end
