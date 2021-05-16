# frozen_string_literal: true

require 'rails_helper'
require 'shared_examples/jsonapi_validations'

RSpec.describe 'Api::V1::MediaItems', type: :request do
  let(:resource) { create(:media_item, storage_backend: create(:s3_storage_backend)) }
  let(:resource_path) { api_v1_media_item_path resource.id }
  let(:resource_type) { 'media-items' }
  let(:resources_path) { api_v1_media_items_path }

  it_behaves_like 'jsonapi_create_validations', 'media-items' do
    let(:storage_backend) { create(:s3_storage_backend) }
    let(:relationships) do
      {
        'storage-backend': {
          data: {
            type: 'storage-backends',
            id: storage_backend.id
          }
        }
      }
    end
  end
  it_behaves_like 'jsonapi_delete_validations', 'media-items'
  it_behaves_like 'jsonapi_read_validations', 'media-items'
  it_behaves_like 'jsonapi_update_validations', 'media-items' do
    let(:attributes) do
      {
        path: 'foo/bar'
      }
    end
  end
end
