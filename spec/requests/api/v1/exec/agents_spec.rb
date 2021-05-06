# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'Api::V1::Exec::Agents', type: :request do
  let(:headers) do
    {
      'Content-Type': 'application/json'
    }
  end

  describe 'POST /register' do
    let(:payload) do
      JSON.dump({
                  addr: '127.0.0.1'
                })
    end

    describe 'new agent' do
      it 'returns http success' do
        post '/api/v1/exec/agents/register', params: payload, headers: headers
        expect(response).to have_http_status(:success)
      end
    end

    describe 'returning agent' do
      let(:agent) do
        create(:agent)
      end

      let(:payload) do
        {
          id: agent.id,
          addr: agent.addr
        }
      end

      it 'returns http success' do
        post '/api/v1/exec/agents/register', params: payload, headers: headers, as: :json
        expect(response).to have_http_status(:success)

        r = JSON.parse(response.body).deep_symbolize_keys
        expect(r[:id]).to eq agent.id
        expect(r[:access_key]).to eq agent.access_key
      end
    end
  end
end
