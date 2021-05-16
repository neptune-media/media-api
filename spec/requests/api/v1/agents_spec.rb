# frozen_string_literal: true

require 'rails_helper'
require 'shared_examples/jsonapi_validations'

RSpec.describe 'Api::V1::Agents', type: :request do
  let(:resource) { create(:agent) }
  let(:resource_path) { api_v1_agent_path resource.id }
  let(:resource_type) { 'agents' }
  let(:resources_path) { api_v1_agents_path }

  include_examples 'jsonapi_delete_validations', 'agents'
  include_examples 'jsonapi_read_validations', 'agents'
  include_examples 'jsonapi_update_validations', 'agents' do
    let(:attributes) do
      {
        'display-name': 'test'
      }
    end
  end
end
