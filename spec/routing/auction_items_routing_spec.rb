# frozen_string_literal: true

require 'rails_helper'

RSpec.describe AuctionItemsController, type: :routing do
  describe 'routing' do
    it 'routes to #index' do
      expect(get: '/auction_items').to route_to('auction_items#index')
    end

    it 'routes to #new' do
      expect(get: '/auction_items/new').to route_to('auction_items#new')
    end

    it 'routes to #show' do
      expect(get: '/auction_items/1').to route_to('auction_items#show', id: '1')
    end

    it 'routes to #create' do
      expect(post: '/auction_items').to route_to('auction_items#create')
    end

    it 'routes to #update via PUT' do
      expect(put: '/auction_items/1').to route_to('auction_items#update', id: '1')
    end

    it 'routes to #update via PATCH' do
      expect(patch: '/auction_items/1').to route_to('auction_items#update', id: '1')
    end

    it 'routes to #destroy' do
      expect(delete: '/auction_items/1').to route_to('auction_items#destroy', id: '1')
    end
  end
end
