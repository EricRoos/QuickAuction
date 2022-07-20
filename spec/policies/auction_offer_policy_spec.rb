# frozen_string_literal: true

require 'rails_helper'

RSpec.describe AuctionOfferPolicy, type: :policy do
  let(:user) { User.new }
  let(:auction_item) { FactoryBot.create(:auction_item) }
  let(:auction_offer) { FactoryBot.create(:auction_offer, auction_item: auction_item) }
  let(:auction_item_approved) { false }

  before do
    auction_offer.auction_item.moderation_item.approve if auction_item_approved
  end

  subject { described_class }

  permissions '.scope' do
    pending "add some examples to (or delete) #{__FILE__}"
  end

  permissions :show? do
    it { is_expected.to_not permit(user, auction_offer) }
  end

  permissions :create? do
    pending "add some examples to (or delete) #{__FILE__}"
  end

  permissions :update? do
    pending "add some examples to (or delete) #{__FILE__}"
  end

  permissions :destroy? do
    pending "add some examples to (or delete) #{__FILE__}"
  end
end
