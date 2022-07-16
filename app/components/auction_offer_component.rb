# frozen_string_literal: true

class AuctionOfferComponent < ViewComponent::Base
  include ActionView::Helpers::DateHelper
  attr_accessor :auction_offer, :loading, :actions_enabled

  def initialize(auction_offer:, loading: false, actions_enabled: true)
    @auction_offer = auction_offer
    @loading = loading
    @actions_enabled = actions_enabled
  end

  def can_destroy_offer?
    false
  end

  def description
    attr_or_loading_line(auction_offer&.description)
  end

  def offered_by
    attr_or_loading_line(auction_offer&.user&.email)
  end

  def offer_state
    attr_or_loading_line(auction_offer&.state)
  end

  def submitted_at
    return loading_line unless auction_offer.present?

    "Submitted #{time_ago_in_words(auction_offer.created_at)} ago"
  end

  protected

  def attr_or_loading_line(val)
    return loading_line if loading

    content_tag(:span, class: 'animate__animated animate__fadeIn') do
      val
    end
  end

  def loading_line
    render(LoadingLineComponent.new)
  end
end
