# frozen_string_literal: true

class LandingPageController < ApplicationController
  skip_before_action :authenticate_user!, unless: :requires_auth?
  skip_after_action :verify_authorized
  skip_before_action :check_beta_access

  REQUIRES_AUTH_LIST = %i[
    request-beta-access
  ].freeze

  layout 'landing_page'
  def show; end

  private

  def requires_auth?
    return if params[:landing_page_id].blank?

    REQUIRES_AUTH_LIST.include?(params[:landing_page_id].to_sym)
  end
end
