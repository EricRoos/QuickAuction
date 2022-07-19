# frozen_string_literal: true

require 'rails_helper'

RSpec.describe AuctionOffersController, type: :routing do
  describe 'routing' do
    it 'routes to #index' do
      expect(get: '/auction_items/1/auction_offers').to route_to('auction_offers#index', auction_item_id: '1')
    end

    it 'routes to #new' do
      expect(get: '/auction_items/1/auction_offers/new').to route_to('auction_offers#new', auction_item_id: '1')
    end

    it 'routes to #show' do
      expect(get: '/auction_offers/1').to route_to('auction_offers#show', id: '1')
    end

    it 'routes to #create' do
      expect(post: '/auction_items/1/auction_offers').to route_to('auction_offers#create', auction_item_id: '1')
    end

    it 'routes to #update via PUT' do
      expect(put: '/auction_offers/1').to route_to('auction_offers#update', id: '1')
    end

    it 'routes to #update via PATCH' do
      expect(patch: '/auction_offers/1').to route_to('auction_offers#update', id: '1')
    end

    it 'routes to #destroy' do
      expect(delete: '/auction_offers/1').to route_to('auction_offers#destroy', id: '1')
    end
  end
end
