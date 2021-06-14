# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'Api::V1::Exec::Media', type: :request do
  describe 'POST /import' do
    it 'returns http success' do
      post '/api/v1/exec/media/import'
      expect(response).to have_http_status(:success)
    end
  end
end
