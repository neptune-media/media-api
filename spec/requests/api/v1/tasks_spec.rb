# frozen_string_literal: true

require 'rails_helper'
require 'shared_examples/jsonapi_validations'

RSpec.describe 'Api::V1::Tasks', type: :request do
  let(:resource) { create(:preview_task) }
  let(:resource_path) { api_v1_task_path resource.id }
  let(:resource_type) { 'tasks' }
  let(:resources_path) { api_v1_tasks_path }

  it_behaves_like 'jsonapi_create_validations', 'tasks' do
    let(:job) { create(:job) }
    let(:attributes) do
      {
        data: {
          apiVersion: 'v1',
          kind: 'task',
          metadata: {},
          spec: {
            kind: 'previewTask'
          }
        }
      }
    end

    let(:relationships) do
      {
        job: {
          data: {
            type: 'jobs',
            id: job.id
          }
        }
      }
    end
  end
  it_behaves_like 'jsonapi_delete_validations', 'tasks'
  it_behaves_like 'jsonapi_read_validations', 'tasks'
  it_behaves_like 'jsonapi_update_validations', 'tasks'
end
