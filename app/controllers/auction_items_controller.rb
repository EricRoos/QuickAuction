# frozen_string_literal: true

class AuctionItemsController < ApplicationController
  before_action :set_auction_item, only: %i[show edit update destroy]

  # GET /auction_items or /auction_items.json
  def index
    @search = ItemSearch.new(search_params.merge(current_user: current_user))
    @auction_items = @search.call
  end

  # GET /auction_items/1 or /auction_items/1.json
  def show
    @current_user_offer = @auction_item.auction_offers.where(user: current_user).first
  end

  # GET /auction_items/new
  def new
    @auction_item = AuctionItem.new
  end

  # POST /auction_items or /auction_items.json
  def create
    @auction_item = current_user.auction_items.build(auction_item_params)

    respond_to do |format|
      if @auction_item.save
        format.html { redirect_to auction_item_url(@auction_item), notice: 'Auction item was successfully created.' }
        format.json { render :show, status: :created, location: @auction_item }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @auction_item.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /auction_items/1 or /auction_items/1.json
  def destroy
    @auction_item.destroy

    respond_to do |format|
      format.html { redirect_to auction_items_url, notice: 'Auction item was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private

  # Use callbacks to share common setup or constraints between actions.
  def set_auction_item
    @auction_item = AuctionItem.find(params[:id])
  end

  # Only allow a list of trusted parameters through.
  def auction_item_params
    params.require(:auction_item).permit(:title, :description)
  end

  def search_params
    params.require(:item_search).permit(:query, :has_no_offers, :my_listings)
  rescue ActionController::ParameterMissing
    {}
  end
end
