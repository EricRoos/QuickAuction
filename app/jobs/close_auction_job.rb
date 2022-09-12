# frozen_string_literal: true

class CloseAuctionJob < ApplicationJob
  queue_as :default

  def perform(auction_item_id)
    auction_item = AuctionItem.find(auction_item_id)
    auction_item.update(expires_on: Time.now) # just to be sure

    # generate some game info
    # generate a game name
    name = (0...5).map { rand(65..90).chr }.join
    # generate a game password
    password = (0...3).map { rand(65..90).chr }.join

    AuctionClosedNotification.with(
      game_name: name,
      game_password: password,
      auction_item_id: auction_item_id
    ).deliver_later([auction_item.user, auction_item.current_accepted_offer.user])
  end
end
