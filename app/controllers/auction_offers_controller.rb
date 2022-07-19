# frozen_string_literal: true

class AuctionOffersController < ApplicationController
  include ActionView::RecordIdentifier
  before_action :set_auction_item, only: %i[index new create]
  before_action :set_auction_offer, only: %i[show edit update destroy]

  # GET /auction_offers or /auction_offers.json
  def index
    authorize AuctionOffer
    rejected_states = %i[
      rejected
      accepted
    ]

    rejected_states << 'sent' if @auction_item.user != current_user

    @current_offer = @auction_item.auction_offers.with_state(:accepted).first
    @proposed_offer = @auction_item.auction_offers
                                   .without_states(rejected_states)
                                   .order(created_at: :asc)
                                   .first
  end

  # GET /auction_offers/1 or /auction_offers/1.json
  def show
    respond_to do |format|
      format.html
      format.turbo_stream do
        render turbo_stream: turbo_stream.replace(request.headers['Turbo-Frame'],
                                                  partial: 'auction_offers/auction_offer', locals: { auction_offer: @auction_offer })
      end
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
          redirect_to auction_item_path(@auction_offer.auction_item),
                      notice: 'Auction offer was successfully created.'
        end
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
      if @auction_offer.update(update_auction_offer_params)
        format.html do
          redirect_to auction_item_auction_offers_url(@auction_offer.auction_item),
                      notice: 'Auction offer was successfully updated.'
        end
        format.json { render :show, status: :ok, location: @auction_offer }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.turbo_stream do
          turbo_stream.replace "form#{dom_id(@auction_offer)}", partial: 'auction_offers/form',
                                                                locals: { auction_offer: @auction_offer }
        end
        format.json { render json: @auction_offer.errors, status: :unprocessable_entity }
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
      format.json { head :no_content }
    end
  end

  private

  # Use callbacks to share common setup or constraints between actions.
  def set_auction_offer
    @auction_offer = AuctionOffer.find(params[:id])
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
