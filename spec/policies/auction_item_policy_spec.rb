# frozen_string_literal: true

require 'rails_helper'

RSpec.describe AuctionItemPolicy, type: :policy do
  let(:user) { FactoryBot.build(:user) }
  let(:auction_item) { FactoryBot.create(:auction_item) }
  let(:auction_item_approved) { false }

  before do
    auction_item.moderation_item.approve if auction_item_approved
  end

  subject { described_class }

  permissions '.scope' do
    pending "add some examples to (or delete) #{__FILE__}"
  end

  permissions :index? do
    it { is_expected.to permit(user) }
  end

  permissions :show? do
    it { is_expected.to_not permit(user, auction_item) }
    context 'when item is approved' do
      let(:auction_item_approved) { true }
      it { is_expected.to permit(user, auction_item) }
    end
  end

  permissions :create?, :new? do
    it { is_expected.to permit(user) }
  end

  permissions :update?, :edit? do
    it { is_expected.to_not permit(user) }
  end

  permissions :destroy? do
    it { is_expected.to_not permit(user, auction_item) }
    context 'when user is owner' do
      it { is_expected.to permit(auction_item.user, auction_item) }
    end
  end
end
