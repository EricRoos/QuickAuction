# frozen_string_literal: true

class AuctionItem < ApplicationRecord
  belongs_to :user
  has_many :auction_offers, dependent: :destroy

  before_commit :ensure_expiry, on: :create

  def offer_count
    attributes['offer_count'] || auction_offers.count
  end

  protected

  def ensure_expiry
    return if expires_on.present?

    self.expires_on = Time.now + 15.minutes
    save
  end
end
