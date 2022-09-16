# frozen_string_literal: true

class AuctionCreatedNotification < Noticed::Base
  # Add your delivery methods
  #
  deliver_by :database
  # deliver_by :email, mailer: "UserMailer"
  # deliver_by :slack
  # deliver_by :custom, class: "MyDeliveryMethod"

  # Add required params
  #
  param :auction_item_id, :auction_title

  # Define helper methods to make rendering easier.
  #
  # def message
  #   t(".message")
  # end
  def message
    "Your auction for #{params[:auction_title]} has been created! We'll let you know as you receive offers"
  end

  #
  # def url
  #   post_path(params[:post])
  # end
end
