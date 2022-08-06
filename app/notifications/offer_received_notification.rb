# frozen_string_literal: true

# To deliver this notification:
#
# OfferUpdatedNotification.with(post: @post).deliver_later(current_user)
# OfferUpdatedNotification.with(post: @post).deliver(current_user)

class OfferReceivedNotification < Noticed::Base
  # Add your delivery methods
  #
  deliver_by :database
  # deliver_by :email, mailer: "UserMailer"
  # deliver_by :slack
  # deliver_by :custom, class: "MyDeliveryMethod"

  # Add required params
  #
  param :auction_item_id

  # Define helper methods to make rendering easier.
  #
  # def message
  #   t(".message")
  # end
  def message
    'You have received a new offer.'
  end
  #
  # def url
  #   post_path(params[:post])
  # end
end
