# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'SupportTickets', type: :request do
  describe 'GET /new' do
    before do
      sign_in FactoryBot.create(:user)
    end
    it 'returns http success' do
      get '/support_tickets/new'
      expect(response).to have_http_status(:success)
    end
  end
end
