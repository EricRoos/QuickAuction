# frozen_string_literal: true

class AuctionItem < ApplicationRecord
  include Moderatable
  belongs_to :user
  has_many :auction_offers, dependent: :destroy
  has_one_attached :auction_image

  before_commit :ensure_expiry, on: :create

  scope :not_expired, -> { where('expires_on >= ?', Time.now) }

  def offer_count
    attributes['offer_count'] || auction_offers.count
  end

  def expired?
    expires_on < Time.now
  end

  protected

  def ensure_expiry
    return if expires_on.present?

    self.expires_on = Time.now + 15.minutes
    save
  end
end
