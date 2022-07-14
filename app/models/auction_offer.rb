# frozen_string_literal: true

class AuctionOffer < ApplicationRecord
  belongs_to :auction_item
  belongs_to :user

  state_machine :state, initial: :sent do
    event :acknowledge do
      transition sent: :acknowledged
    end

    event :accept do
      transition read: :accepted
      transition sent: :accepted
      transition acknowledged: :accepted
    end

    event :reject do
      transition read: :rejected
      transition sent: :rejected
      transition acknowledged: :rejected
    end

  end

  def available_transition_events
    state_paths.map(&:first).collect(&:event).uniq
  end

end
