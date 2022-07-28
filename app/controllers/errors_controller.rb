# frozen_string_literal: true

class ErrorsController < ApplicationController
  skip_before_action :authenticate_user!
  skip_after_action :verify_authorized

  def not_found; end

  def not_authorized
    render status: 401
  end
end
