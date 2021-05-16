# frozen_string_literal: true

RSpec.shared_examples 'jsonapi_create_validations' do |name|
  let(:attributes) { {} }
  let(:headers) do
    {
      'Content-Type': 'application/vnd.api+json'
    }
  end
  let(:relationships) { {} }

  describe "POST /#{name}" do
    let(:payload) do
      {
        data: {
          type: resource_type,
          attributes: attributes,
          relationships: relationships
        }
      }
    end

    it 'returns http success' do
      post resources_path, params: JSON.dump(payload), headers: headers
      pp JSON.parse(response.body) unless response.status == 201
      expect(response).to have_http_status(:success)
    end
  end
end

RSpec.shared_examples 'jsonapi_delete_validations' do |name|
  describe "DELETE /#{name}/:id" do
    it 'returns http success' do
      delete resource_path
      expect(response).to have_http_status(:success)
    end
  end
end

RSpec.shared_examples 'jsonapi_read_validations' do |name|
  describe "GET /#{name}" do
    it 'returns http success' do
      get resources_path
      expect(response).to have_http_status(:success)
    end
  end

  describe "GET /#{name}/:id" do
    it 'returns http success' do
      get resource_path
      expect(response).to have_http_status(:success)
    end
  end
end

RSpec.shared_examples 'jsonapi_update_validations' do |name|
  let(:attributes) { {} }
  let(:headers) do
    {
      'Content-Type': 'application/vnd.api+json'
    }
  end
  let(:relationships) { {} }

  describe "PATCH /#{name}/:id" do
    let(:payload) do
      {
        data: {
          id: resource.id,
          type: resource_type,
          attributes: attributes,
          relationships: relationships
        }
      }
    end

    it 'returns http success' do
      patch resource_path, params: JSON.dump(payload), headers: headers
      expect(response).to have_http_status(:success)
    end
  end
end
