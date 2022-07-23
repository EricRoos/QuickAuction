# frozen_string_literal: true

class ApplicationController < ActionController::Base
  include Pundit::Authorization

  before_action :authenticate_user!
  before_action :log_current_user
  before_action :add_initial_breadcrumbs

  after_action :verify_authorized, unless: -> { devise_controller? }

  default_form_builder AppFormBuilder

  def log_current_user
    Rails.logger.info "CURRENT USER:\t #{current_user&.id}"
  end

  protected

  def add_initial_breadcrumbs
    breadcrumbs.add 'Home', root_path
  end
end
