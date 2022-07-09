# frozen_string_literal: true

class AuctionOffer < ApplicationRecord
  belongs_to :auction_item
  belongs_to :user

  validate :submitter_is_not_owner

  state_machine :state, initial: :sent do
    event :read do
      transition sent: :read
    end
    event :accept do
      transition read: :accepted
    end
    event :reject do
      transition read: :rejected
    end
  end

  def available_transition_events
    state_paths.map(&:first).collect(&:event).uniq
  end

  protected

  def submitter_is_not_owner
    return unless user == auction_item.user

    errors.add(:user, :submitter_is_owner, message: 'You cannot submit to your own auction item')
  end
end
