# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'Api::V1::Exec::Media', type: :request do
  describe 'GET /import' do
    it 'returns http success' do
      get '/api/v1/exec/media/import'
      expect(response).to have_http_status(:success)
    end
  end
end
