# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'Api::V1::Exec::Tasks', type: :request do
  describe 'GET /poll' do
    it 'returns http success' do
      get '/api/v1/exec/tasks/poll'
      expect(response).to have_http_status(:success)
    end
  end

  describe 'POST /acquire' do
    it 'returns http success' do
      post '/api/v1/exec/tasks/acquire'
      expect(response).to have_http_status(:success)
    end
  end

  describe 'POST /release' do
    it 'returns http success' do
      post '/api/v1/exec/tasks/release'
      expect(response).to have_http_status(:success)
    end
  end
end
