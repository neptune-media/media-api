# frozen_string_literal: true

require 'rails_helper'
require 'shared_examples/jsonapi_validations'

RSpec.describe 'Api::V1::Jobs', type: :request do
  let(:resource) { create(:job) }
  let(:resource_path) { api_v1_job_path resource.id }
  let(:resource_type) { 'jobs' }
  let(:resources_path) { api_v1_jobs_path }

  include_examples 'jsonapi_create_validations', 'jobs'
  include_examples 'jsonapi_delete_validations', 'jobs'
  include_examples 'jsonapi_read_validations', 'jobs'
  # include_examples 'jsonapi_update_validations', 'jobs' do
  #   let(:attributes) do
  #     {
  #       'display-name': 'test'
  #     }
  #   end
  # end
end
