# frozen_string_literal: true

require 'rails_helper'

RSpec.describe AuctionItem, type: :model do
  let(:auction_item) { FactoryBot.create(:auction_item) }
  subject { auction_item }
  it { is_expected.to be_persisted }
end
