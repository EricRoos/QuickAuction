# frozen_string_literal: true

class AuctionClosedNotification < Noticed::Base
  deliver_by :database
  # deliver_by :email, mailer: "UserMailer"
  # deliver_by :slack
  # deliver_by :custom, class: "MyDeliveryMethod"

  param :auction_item_id, :game_password, :game_name

  def message
    # rubocop:disable Layout/LineLength
    "Auction closed. Seller, please create a game with the name <b>#{params[:game_name]}</b> with password <b>#{params[:game_password]}</b> in the NA region".html_safe
    # rubocop:enable Layout/LineLength
  end
end
