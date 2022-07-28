# frozen_string_literal: true

require 'rails_helper'

RSpec.describe ItemSearch, type: :model do
  context 'moderated item exists by name' do
    let(:title) { 'title 1' }
    let(:current_user) { FactoryBot.create(:user) }
    before do
      FactoryBot.create(:moderated_auction_item, title: title)
    end
    subject { ItemSearch.new(current_user: current_user, query: title).call }
    it { is_expected.to_not be_empty }
  end

  context 'moderated item does not exist by name' do
    let(:title) { 'title 1' }
    let(:current_user) { FactoryBot.create(:user) }
    before do
      FactoryBot.create(:moderated_auction_item, title: title)
    end
    subject { ItemSearch.new(current_user: current_user, query: 'bad query').call }
    it { is_expected.to be_empty }
  end

  context 'expired items do not exist' do
    let(:title) { 'title 1' }
    let(:current_user) { FactoryBot.create(:user) }
    before do
      item = FactoryBot.create(:moderated_auction_item, title: title)
      item.update(expires_on: 1.weeks.ago)
    end
    subject { ItemSearch.new(current_user: current_user, query: title).call }
    it { is_expected.to be_empty }
  end

  context 'non moderated item exists' do
    let(:title) { 'title 1' }
    let(:current_user) { FactoryBot.create(:user) }
    before do
      FactoryBot.create(:auction_item, title: title)
    end

    subject { ItemSearch.new(current_user: current_user, query: title).call }
    it { is_expected.to be_empty }
  end

  context 'can see my own non moderated item' do
    let(:title) { 'title 1' }
    let(:current_user) { FactoryBot.create(:user) }
    before do
      FactoryBot.create(:auction_item, title: title, user: current_user)
    end

    subject { ItemSearch.new(current_user: current_user, query: title, my_listings: true).call }
    it { is_expected.to_not be_empty }
  end
end
