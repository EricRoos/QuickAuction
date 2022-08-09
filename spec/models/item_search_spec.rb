# frozen_string_literal: true

require 'rails_helper'

RSpec.describe ItemSearch, type: :model do
  let(:current_user) { FactoryBot.create(:user) }

  context 'with tags' do
    let!(:auction_item) { FactoryBot.create(:moderated_auction_item, game_item_list: ['Item1']) }
    subject { ItemSearch.new(current_user: current_user, tags: ['Item1']).call }
    it { is_expected.to match_array([auction_item]) }
  end

  context 'with non existent tags' do
    let!(:auction_item) { FactoryBot.create(:moderated_auction_item, game_item_list: ['Item2']) }
    subject { ItemSearch.new(current_user: current_user, tags: ['Item1']).call }
    it { is_expected.to be_empty }
  end

  context 'moderated item exists by name' do
    let(:title) { 'title 1' }
    let!(:auction_item) { FactoryBot.create(:moderated_auction_item, title: title) }
    subject { ItemSearch.new(current_user: current_user, query: title).call }
    it { is_expected.to match_array([auction_item]) }
  end

  context 'moderated item does not exist by name' do
    before do
      FactoryBot.create(:moderated_auction_item)
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
    let!(:auction_item) { FactoryBot.create(:auction_item, title: title, user: current_user) }
    subject { ItemSearch.new(current_user: current_user, query: title, my_listings: true).call }
    it { is_expected.to match_array([auction_item]) }
  end
end
