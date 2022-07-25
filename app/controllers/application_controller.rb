# frozen_string_literal: true

class ApplicationController < ActionController::Base
  include Pundit::Authorization

  before_action :check_public_access_enabled, if: -> { devise_controller? }
  before_action :authenticate_user!
  before_action :add_initial_breadcrumbs

  after_action :verify_authorized, unless: -> { devise_controller? || active_admin_request? }

  default_form_builder AppFormBuilder

  def after_sign_in_path_for(_resource)
    auction_items_path
  end

  protected

  def check_public_access_enabled
    redirect_to root_path unless Rails.env.test? || Flipper.enabled?(:public_access)
  end

  def active_admin_request?
    request.path.starts_with?('/admin')
    true
  end

  def add_initial_breadcrumbs
    breadcrumbs.add 'Home', root_path
  end
end
