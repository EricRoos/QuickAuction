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

  def restart_auction
    update(expires_on: 30.minutes.from_now)
  end

  def current_accepted_offer
    auction_offers.with_state(:accepted).first
  end

  def current_proposed_offer(include_sent: false)
    rejected_states = %i[
      rejected
      accepted
    ]
    rejected_states << 'sent' if include_sent
    auction_offers
      .without_states(rejected_states)
      .order(created_at: :asc)
      .first
  end

  protected

  def ensure_expiry
    return if expires_on.present?

    self.expires_on = Time.now + 15.minutes
    save
  end
end
