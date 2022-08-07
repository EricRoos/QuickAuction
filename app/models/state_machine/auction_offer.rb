# frozen_string_literal: true

module StateMachine
  module AuctionOffer
    extend ActiveSupport::Concern
    include Base

    included do
      after_create do
        OfferReceivedNotification.with(auction_item_id: auction_item_id).deliver_later(auction_item.user)
        OfferUpdatedNotification.with(auction_item_id: auction_item_id,
                                      auction_title: auction_item.title, new_state: state).deliver_later(user)
      end

      state_machine :state, initial: :sent do
        after_transition do |offer, _transition|
          OfferUpdatedNotification.with(auction_item_id: offer.auction_item_id,
                                        auction_title: offer.auction_item.title,
                                        new_state: offer.state)
                                  .deliver(offer.user)
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
                                                      offer.auction_item
                                                           .auction_offers
                                                           .without_states(:accepted, :rejected)
                                                           .count.zero?
                                                  }
        end

        event :reject do
          transition read: :rejected, unless: ->(offer) { offer.auction_item.expired? }
          transition sent: :rejected, unless: ->(offer) { offer.auction_item.expired? }
          transition acknowledged: :rejected, unless: ->(offer) { offer.auction_item.expired? }
        end
      end
    end
  end
end
