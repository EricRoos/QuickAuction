# frozen_string_literal: true

class AuctionItemsController < ApplicationController
  before_action :set_auction_item, only: %i[show edit update destroy]
  skip_before_action :authenticate_user!, only: %i[index show]

  # GET /auction_items or /auction_items.json
  def index
    authorize AuctionItem
    @search = ItemSearch.new(search_params.merge(current_user: current_user))
    @auction_items = @search.call
  end

  # GET /auction_items/1 or /auction_items/1.json
  def show
    @current_user_offer = @auction_item.auction_offers.where(user: current_user).first
    @accepted_user_offer = @auction_item.auction_offers.with_state(:accepted).first if @auction_item.expired?
  end

  # GET /auction_items/new
  def new
    @auction_item = AuctionItem.new(auction_item_params)
    @current_step = params[:step] || 1
    @current_step = @current_step.to_i
    if @auction_item.game_item && @auction_item.title.blank?
      @auction_item.title = "Trading my #{@auction_item.game_item.name} for ..."
    end
    authorize @auction_item
  end

  # POST /auction_items or /auction_items.json
  def create
    @auction_item = current_user.auction_items.build(auction_item_params)
    @current_step = params[:step] || 1
    authorize @auction_item

    respond_to do |format|
      if @auction_item.save
        format.html { redirect_to auction_item_url(@auction_item), notice: 'Auction item was successfully created.' }
      else
        format.html { render :new, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /auction_items/1 or /auction_items/1.json
  def destroy
    @auction_item.destroy

    respond_to do |format|
      format.html { redirect_to auction_items_url, notice: 'Auction item was successfully destroyed.' }
    end
  end

  # Only allow a list of trusted parameters through.
  def auction_item_params
    return {} if action_name == 'new' && params[:auction_item].blank?

    params.require(:auction_item).permit(:title, :description, :auction_image, :game_item_id)
  end
  helper_method :auction_item_params

  private

  # Use callbacks to share common setup or constraints between actions.
  def set_auction_item
    @auction_item = AuctionItem.find(params[:id])
    authorize @auction_item
  end

  def search_params
    params.require(:item_search).permit(:query, :has_no_offers, :my_listings, :include_expired, :is_ladder,
                                        :is_hardcore)
  rescue ActionController::ParameterMissing
    {}
  end
end
