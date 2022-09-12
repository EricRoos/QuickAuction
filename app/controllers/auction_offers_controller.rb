# frozen_string_literal: true

class AuctionOffersController < ApplicationController
  include ActionView::RecordIdentifier
  before_action :set_auction_item, only: %i[index new create]
  before_action :set_auction_offer, only: %i[show edit update destroy]

  skip_before_action :authenticate_user!, only: %i[index]
  skip_before_action :check_beta_access, only: %i[index]

  # GET /auction_offers or /auction_offers.json
  def index
    authorize AuctionOffer
    @current_offer = @auction_item.current_accepted_offer
    @proposed_offer = @auction_item.current_proposed_offer
  end

  # GET /auction_offers/1 or /auction_offers/1.json
  def show
    respond_to do |format|
      format.turbo_stream
    end
  end

  # GET /auction_offers/new
  def new
    @current_user_offer = @auction_item.auction_offers.where(user: current_user).first
    @auction_offer = @auction_item.auction_offers.build
    authorize @auction_offer

    respond_to do |format|
      format.html
      format.turbo_stream do
        render turbo_stream: turbo_stream.replace('offer_form', partial: 'auction_offers/form',
                                                                locals: { auction_offer: @auction_offer })
      end
    end
  end

  # POST /auction_offers or /auction_offers.json
  def create
    @auction_offer = @auction_item.auction_offers.build(auction_offer_params)
    authorize @auction_offer

    respond_to do |format|
      if @auction_offer.save
        format.html do
          redirect_to auction_item_path(@auction_offer.auction_item), notice: 'Auction offer was successfully created.'
        end
      else
        format.html { render :new, status: :unprocessable_entity }
        format.turbo_stream
      end
    end
  end

  # PATCH/PUT /auction_offers/1 or /auction_offers/1.json
  def update
    respond_to do |format|
      if @auction_offer.update(update_auction_offer_params)
        format.html do
          redirect_to auction_item_auction_offers_url(@auction_offer.auction_item),
                      notice: 'Auction offer was successfully updated.'
        end
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.turbo_stream
      end
    end
  end

  # DELETE /auction_offers/1 or /auction_offers/1.json
  def destroy
    @auction_offer.destroy

    respond_to do |format|
      format.html do
        redirect_to auction_item_auction_offers_url(@auction_offer.auction_item),
                    notice: 'Auction offer was successfully destroyed.'
      end
    end
  end

  private

  # Use callbacks to share common setup or constraints between actions.
  def set_auction_offer
    @auction_offer ||= @auction_item.auction_offers.find(params[:id]) if @auction_item.present?
    @auction_offer ||= AuctionOffer.find(params[:id])
    authorize @auction_offer
  end

  # Only allow a list of trusted parameters through.
  def auction_offer_params
    params.require(:auction_offer).permit(:description).merge(user: current_user)
  end

  def update_auction_offer_params
    params.require(:auction_offer).permit(:state_event)
  end

  def set_auction_item
    @auction_item = AuctionItem.find(params[:auction_item_id])
  end
end
