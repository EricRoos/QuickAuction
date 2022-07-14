# frozen_string_literal: true

require 'rails_helper'

# This spec was generated by rspec-rails when you ran the scaffold generator.
# It demonstrates how one might use RSpec to test the controller code that
# was generated by Rails when you ran the scaffold generator.
#
# It assumes that the implementation code is generated by the rails scaffold
# generator. If you are using any extension libraries to generate different
# controller code, this generated spec may or may not pass.
#
# It only uses APIs available in rails and/or rspec-rails. There are a number
# of tools you can use to make these specs even more expressive, but we're
# sticking to rails and rspec-rails APIs to keep things simple and stable.

RSpec.describe '/auction_offers', type: :request do
  # This should return the minimal set of attributes required to create a valid
  # AuctionOffer. As you add validations to AuctionOffer, be sure to
  # adjust the attributes here as well.
  let(:valid_attributes) do
    skip('Add a hash of attributes valid for your model')
  end

  let(:invalid_attributes) do
    skip('Add a hash of attributes invalid for your model')
  end

  describe 'GET /index' do
    it 'renders a successful response' do
      AuctionOffer.create! valid_attributes
      get auction_offers_url
      expect(response).to be_successful
    end
  end

  describe 'GET /show' do
    it 'renders a successful response' do
      auction_offer = AuctionOffer.create! valid_attributes
      get auction_offer_url(auction_offer)
      expect(response).to be_successful
    end
  end

  describe 'GET /new' do
    it 'renders a successful response' do
      get new_auction_offer_url
      expect(response).to be_successful
    end
  end

  describe 'POST /create' do
    context 'with valid parameters' do
      it 'creates a new AuctionOffer' do
        expect do
          post auction_offers_url, params: { auction_offer: valid_attributes }
        end.to change(AuctionOffer, :count).by(1)
      end

      it 'redirects to the created auction_offer' do
        post auction_offers_url, params: { auction_offer: valid_attributes }
        expect(response).to redirect_to(auction_offer_url(AuctionOffer.last))
      end
    end

    context 'with invalid parameters' do
      it 'does not create a new AuctionOffer' do
        expect do
          post auction_offers_url, params: { auction_offer: invalid_attributes }
        end.to change(AuctionOffer, :count).by(0)
      end

      it "renders a successful response (i.e. to display the 'new' template)" do
        post auction_offers_url, params: { auction_offer: invalid_attributes }
        expect(response).to be_successful
      end
    end
  end

  describe 'PATCH /update' do
    context 'with valid parameters' do
      let(:new_attributes) do
        skip('Add a hash of attributes valid for your model')
      end

      it 'updates the requested auction_offer' do
        auction_offer = AuctionOffer.create! valid_attributes
        patch auction_offer_url(auction_offer), params: { auction_offer: new_attributes }
        auction_offer.reload
        skip('Add assertions for updated state')
      end

      it 'redirects to the auction_offer' do
        auction_offer = AuctionOffer.create! valid_attributes
        patch auction_offer_url(auction_offer), params: { auction_offer: new_attributes }
        auction_offer.reload
        expect(response).to redirect_to(auction_offer_url(auction_offer))
      end
    end

    context 'with invalid parameters' do
      it "renders a successful response (i.e. to display the 'edit' template)" do
        auction_offer = AuctionOffer.create! valid_attributes
        patch auction_offer_url(auction_offer), params: { auction_offer: invalid_attributes }
        expect(response).to be_successful
      end
    end
  end

  describe 'DELETE /destroy' do
    it 'destroys the requested auction_offer' do
      auction_offer = AuctionOffer.create! valid_attributes
      expect do
        delete auction_offer_url(auction_offer)
      end.to change(AuctionOffer, :count).by(-1)
    end

    it 'redirects to the auction_offers list' do
      auction_offer = AuctionOffer.create! valid_attributes
      delete auction_offer_url(auction_offer)
      expect(response).to redirect_to(auction_offers_url)
    end
  end
end
