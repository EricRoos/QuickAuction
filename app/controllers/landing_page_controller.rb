# frozen_string_literal: true

class LandingPageController < ApplicationController
  skip_before_action :authenticate_user!
  skip_after_action :verify_authorized
  layout 'landing_page'
  def show; end
end
