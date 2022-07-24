# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'Inboxes', type: :request do
  before do
    sign_in FactoryBot.create(:user)
  end
  describe 'GET /index' do
    it 'returns http success' do
      get '/inbox'
      expect(response).to have_http_status(:success)
    end
  end
end
