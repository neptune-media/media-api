# frozen_string_literal: true

require 'rails_helper'
require 'shared_examples/jsonapi_validations'

RSpec.describe 'Api::V1::StorageBackends', type: :request do
  let(:resource) { create(:s3_storage_backend) }
  let(:resource_path) { api_v1_storage_backend_path resource.id }
  let(:resource_type) { 'storage-backends' }
  let(:resources_path) { api_v1_storage_backends_path }

  it_behaves_like 'jsonapi_create_validations', 'storage-backends' do
    let(:attributes) do
      {
        'backend-type': 's3',
        bucket: 'test-bucket',
        prefix: 'foo',
        'access-key': 'foo',
        'secret-key': 'bar'
      }
    end
  end
  it_behaves_like 'jsonapi_delete_validations', 'storage-backends'
  it_behaves_like 'jsonapi_read_validations', 'storage-backends'
  it_behaves_like 'jsonapi_update_validations', 'storage-backends'
end
