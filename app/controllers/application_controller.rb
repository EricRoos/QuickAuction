# frozen_string_literal: true

class ApplicationController < ActionController::Base
  include Pundit::Authorization

  before_action :check_public_access_enabled, if: -> { devise_controller? && !active_admin_request? }
  before_action :authenticate_user!, unless: -> { active_admin_request? }
  before_action :add_initial_breadcrumbs

  after_action :verify_authorized, unless: -> { devise_controller? || active_admin_request? }

  default_form_builder AppFormBuilder

  rescue_from Pundit::NotAuthorizedError, with: :render_not_authorized

  def after_sign_in_path_for(resource)
    return admin_dashboard_path if resource.is_a?(AdminUser)

    auction_items_path
  end

  def root_path
    return super unless current_user.present?

    auction_items_path
  end
  helper_method :root_path

  protected

  def render_not_authorized
    redirect_to '/401' and return
  end

  def check_public_access_enabled
    redirect_to root_path unless Rails.env.test? || Flipper.enabled?(:public_access)
  end

  def active_admin_request?
    request.path.starts_with?('/admin')
  end

  def add_initial_breadcrumbs
    breadcrumbs.add 'Home', root_path
  end
end
