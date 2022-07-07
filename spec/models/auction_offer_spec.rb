# frozen_string_literal: true

require 'rails_helper'

RSpec.describe AuctionOffer, type: :model do
  let(:auction_offer) { FactoryBot.create(:auction_offer) }
  subject { auction_offer }
  it { is_expected.to be_persisted }

  context 'when the offer is from the listing' do
    before do
      auction_offer.user = auction_offer.auction_item.user
    end
    it { is_expected.to_not be_valid }
  end
end
