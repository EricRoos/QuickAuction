# frozen_string_literal: true

class AuctionOffer < ApplicationRecord
  belongs_to :auction_item
  belongs_to :user

  before_save :replace_accepted

  state_machine :state, initial: :sent do
    after_transition do |offer, _transition|
      OfferUpdatedNotification.with(auction_offer: offer, new_state: offer.state).deliver(offer.user)
    end

    before_transition any => :accepted do |offer, _transition|
      offer.auction_item.auction_offers.with_states(:accepted).each(&:accept_other_offer)
    end

    event :acknowledge do
      transition sent: :acknowledged, unless: ->(offer) { offer.auction_item.expired? }
    end

    event :accept do
      transition read: :accepted, unless: ->(offer) { offer.auction_item.expired? }
      transition sent: :accepted, unless: ->(offer) { offer.auction_item.expired? }
      transition acknowledged: :accepted, unless: ->(offer) { offer.auction_item.expired? }
    end

    event :cancel_accept do
      transition accepted: :acknowledged, unless: ->(offer) { offer.auction_item.expired? }
    end

    event :accept_other_offer do
      transition accepted: :rejected, unless: lambda { |offer|
                                                offer.auction_item.expired? ||
                                                  offer.auction_item.auction_offers.without_states(:accepted, :rejected).count.zero?
                                              }
    end

    event :reject do
      transition read: :rejected, unless: ->(offer) { offer.auction_item.expired? }
      transition sent: :rejected, unless: ->(offer) { offer.auction_item.expired? }
      transition acknowledged: :rejected, unless: ->(offer) { offer.auction_item.expired? }
    end
  end

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

    auction_item.auction_offers.with_states(:accepted).each(&:accept_other_offer)
  end
end
