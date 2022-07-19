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

  describe 'accepting offer rejects others' do
    let(:auction_item) { FactoryBot.create(:auction_item) }
    let(:offer) { FactoryBot.create(:auction_offer, auction_item: auction_item) }

    before do
      FactoryBot.create(:auction_offer, auction_item: auction_item).accept
      offer.accept
    end

    subject { auction_item.auction_offers.with_state(:accepted) }
    it { is_expected.to eq [offer] }
  end
end
