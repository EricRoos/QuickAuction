# frozen_string_literal: true

class GameItemsController < ApplicationController
  def index
    authorize GameItem
    @game_items = GameItem.where('lower(name) like ?', "%#{params[:query]&.downcase}%")
  end
end
