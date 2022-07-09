# frozen_string_literal: true

class AuctionOffersController < ApplicationController
  before_action :set_auction_item, only: %i[index new create]
  before_action :set_auction_offer, only: %i[show edit update destroy]

  # GET /auction_offers or /auction_offers.json
  def index
    @auction_offers = AuctionOffer.all
  end

  # GET /auction_offers/1 or /auction_offers/1.json
  def show; end

  # GET /auction_offers/new
  def new
    @auction_offer = AuctionOffer.new
  end

  # GET /auction_offers/1/edit
  def edit; end

  # POST /auction_offers or /auction_offers.json
  def create
    @auction_offer = @auction_item.auction_offers.build(auction_offer_params)

    respond_to do |format|
      if @auction_offer.save
        format.html { redirect_to auction_offer_url(@auction_offer), notice: 'Auction offer was successfully created.' }
        format.json { render :show, status: :created, location: @auction_offer }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @auction_offer.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /auction_offers/1 or /auction_offers/1.json
  def update
    respond_to do |format|
      if @auction_offer.update(auction_offer_params)
        format.html { redirect_to auction_offer_url(@auction_offer), notice: 'Auction offer was successfully updated.' }
        format.json { render :show, status: :ok, location: @auction_offer }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @auction_offer.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /auction_offers/1 or /auction_offers/1.json
  def destroy
    @auction_offer.destroy

    respond_to do |format|
      format.html { redirect_to auction_offers_url, notice: 'Auction offer was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private

  # Use callbacks to share common setup or constraints between actions.
  def set_auction_offer
    @auction_offer = AuctionOffer.find(params[:id])
  end

  # Only allow a list of trusted parameters through.
  def auction_offer_params
    params.require(:auction_offer).permit(:auction_item_id, :description).merge(user: current_user)
  end

  def set_auction_item
    @auction_item = AuctionItem.find(params[:auction_item_id])
  end
end
