# frozen_string_literal: true

require 'rails_helper'
require 'shared_examples/jsonapi_validations'

RSpec.describe 'Api::V1::Agents', type: :request do
  let(:resource) { create(:agent) }
  let(:resource_path) { api_v1_agent_path resource.id }
  let(:resource_type) { 'agents' }
  let(:resources_path) { api_v1_agents_path }

  it_behaves_like 'jsonapi_delete_validations', 'agents'
  it_behaves_like 'jsonapi_read_validations', 'agents'
  it_behaves_like 'jsonapi_update_validations', 'agents' do
    let(:attributes) do
      {
        'display-name': 'test'
      }
    end
  end
end
