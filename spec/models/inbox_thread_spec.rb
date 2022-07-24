# frozen_string_literal: true

require 'rails_helper'

RSpec.describe InboxThread, type: :model do
  describe '#auction_threads_for' do
    let(:user) { FactoryBot.create(:user) }

    subject { described_class.auction_threads_for(user) }
    before do
      3.times do
        FactoryBot.create(:auction_offer, user: user).accept
      end
    end

    it { is_expected.to have_attributes(size: 3) }
  end
end
