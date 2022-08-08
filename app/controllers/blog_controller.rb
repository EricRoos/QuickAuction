# frozen_string_literal: true

class BlogController < ApplicationController
  skip_before_action :authenticate_user!
  skip_after_action :verify_authorized
  skip_before_action :check_beta_access

  layout 'landing_page'

  def show
    @blog = Blog.find(params[:slug])
    render and return if current_admin_user.present?

    redirect_to root_path unless @blog.published
  end
end
