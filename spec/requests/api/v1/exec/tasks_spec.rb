# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'Api::V1::Exec::Tasks', type: :request do
  let(:agent) { create(:agent) }
  let(:headers) do
    {
      Authorization: "Bearer #{agent.access_key}"
    }
  end

  describe 'GET /poll' do
    it 'returns http success' do
      get '/api/v1/exec/tasks/poll', headers: headers
      expect(response).to have_http_status(:success)
    end
  end

  describe 'POST /acquire' do
    let(:task) { create(:preview_task, state: :pending) }

    it 'returns http success' do
      post "/api/v1/exec/tasks/acquire/#{task.id}", headers: headers
      expect(response).to have_http_status(:success)
    end
  end

  describe 'POST /release' do
    describe 'acquired task' do
      let(:task) { create(:preview_task, state: :acquired) }

      it 'returns http success' do
        post "/api/v1/exec/tasks/release/#{task.id}", headers: headers
        expect(response).to have_http_status(:success)

        task.reload
        expect(task.state).to eq 'pending'
      end
    end

    describe 'failed task' do
      let(:task) { create(:preview_task, state: :running) }

      it 'returns http success' do
        post "/api/v1/exec/tasks/release/#{task.id}", headers: headers, params: { success: false }, as: :json
        expect(response).to have_http_status(:success)

        task.reload
        expect(task.state).to eq 'failed'
      end
    end

    describe 'pending task' do
      let(:task) { create(:preview_task, state: :pending) }

      it 'returns http success' do
        post "/api/v1/exec/tasks/release/#{task.id}", headers: headers, params: { success: false }, as: :json
        expect(response).to have_http_status(:bad_request)

        task.reload
        expect(task.state).to eq 'pending'
      end
    end

    describe 'running task' do
      let(:task) { create(:preview_task, state: :running) }

      it 'returns http success' do
        post "/api/v1/exec/tasks/release/#{task.id}", headers: headers, params: { success: true }, as: :json
        expect(response).to have_http_status(:success)

        task.reload
        expect(task.state).to eq 'finished'
      end
    end
  end

  describe 'POST /update' do
    let(:task) { create(:preview_task, state: :acquired) }

    it 'returns http success' do
      post "/api/v1/exec/tasks/update/#{task.id}", headers: headers, params: { state: 'running' }, as: :json
      expect(response).to have_http_status(:no_content)

      task.reload
      expect(task.state).to eq 'running'
    end
  end
end
