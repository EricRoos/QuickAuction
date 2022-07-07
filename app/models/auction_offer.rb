# frozen_string_literal: true

class AuctionOffer < ApplicationRecord
  belongs_to :auction_item
  belongs_to :user

  validate :submitter_is_not_owner

  protected

  def submitter_is_not_owner
    return unless user == auction_item.user

    errors.add(:user, :submitter_is_owner, message: 'You cannot submit to your own auction item')
  end
end
