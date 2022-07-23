# frozen_string_literal: true

class AuctionOffer < ApplicationRecord
  include StateMachine::AuctionOffer

  belongs_to :auction_item
  belongs_to :user

  before_save :replace_accepted
  validates_presence_of :description

  def available_transition_events
    state_paths.map(&:first).collect(&:event).uniq
  end

  protected

  def check_auction_not_expired
    return unless auction_item.expired?

    errors.add[:auction_item] << 'is expired'
  end

  def replace_accepted
    return unless accepted?

    auction_item
      .auction_offers
      .with_states(:accepted)
      .each(&:accept_other_offer)
  end
end
