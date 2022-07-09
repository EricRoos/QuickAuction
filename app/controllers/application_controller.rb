# frozen_string_literal: true

class ApplicationController < ActionController::Base
  before_action :authenticate_user!
  before_action :log_current_user

  def log_current_user
    Rails.logger.info "CURRENT USER:\t #{current_user&.id}"
  end
end
