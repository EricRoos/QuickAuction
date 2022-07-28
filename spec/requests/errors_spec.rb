# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'Errors', type: :request do
  describe 'GET /not_found' do
    it 'returns http success' do
      get '/errors/not_found'
      expect(response).to have_http_status(404)
    end
  end

  describe 'GET /not_authorized' do
    it 'returns http success' do
      get '/errors/not_authorized'
      expect(response).to have_http_status(401)
    end
  end
end
