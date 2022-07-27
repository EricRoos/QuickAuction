# frozen_string_literal: true

class LandingPageController < ApplicationController
  skip_before_action :authenticate_user!
  skip_after_action :verify_authorized
  before_action do
    redirect_to auction_items_path if current_user.present?
  end

  layout 'landing_page'
  def show; end
end
