# frozen_string_literal: true

class HelpArticlesController < ApplicationController
  skip_after_action :verify_authorized

  def show
    return if fragment_exist?(cache_key)

    @help_article = HelpArticle.find_by_slug(params[:id])
  end

  private

  def cache_key
    [:help_article, params[:id]]
  end
  helper_method :cache_key
end
