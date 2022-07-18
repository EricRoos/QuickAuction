# frozen_string_literal: true

# To deliver this notification:
#
# OfferUpdatedNotification.with(post: @post).deliver_later(current_user)
# OfferUpdatedNotification.with(post: @post).deliver(current_user)

class OfferUpdatedNotification < Noticed::Base
  # Add your delivery methods
  #
  deliver_by :database
  # deliver_by :email, mailer: "UserMailer"
  # deliver_by :slack
  # deliver_by :custom, class: "MyDeliveryMethod"

  # Add required params
  #
  param :auction_offer, :new_state

  # Define helper methods to make rendering easier.
  #
  # def message
  #   t(".message")
  # end
  def message
    "Your offer for #{params[:auction_offer].auction_item.title} was updated to: #{params[:new_state]}"
  end
  #
  # def url
  #   post_path(params[:post])
  # end
end
