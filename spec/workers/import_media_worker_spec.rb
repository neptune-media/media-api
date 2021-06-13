# frozen_string_literal: true

require 'rails_helper'
RSpec.describe ImportMediaWorker, type: :worker do
  subject(:worker) do
    w = described_class.new
    w.s3_client_opts = s3_client_opts

    w
  end

  let(:metadata) do
    {
      sha256: 'abc123',
      import_path: '/tmp/media/import/123.mkv'
    }
  end
  let(:storage_backend) { create(:minio_storage_backend) }
  let(:s3_client_opts) do
    {
      stub_responses: true
    }
  end

  before do
    worker.client(storage_backend.id).stub_responses(
      :get_object,
      { body: '{}' }
    )
  end

  describe '#get_metadata' do
    let(:path) { 'foo.mkv' }
    let(:metadata_path) { "#{path}.json" }

    it 'returns a Hash' do
      expect(worker.get_metadata(storage_backend.id, path)).to be_a Hash
    end
  end

  describe '#parse_metadata' do
    it 'returns a Hash' do
      expect(worker.parse_metadata(metadata)).to be_a Hash
    end

    it 'sets data.import_path' do
      expect(worker.parse_metadata(metadata)[:data][:sha256]).to eq metadata['import_path']
    end

    it 'sets sha256' do
      expect(worker.parse_metadata(metadata)[:sha256]).to eq metadata['sha256']
    end
  end

  describe '#perform' do
    let(:path) { 'foo.mkv' }

    it 'creates a MediaItem' do
      worker.perform storage_backend.id, path, s3_client_opts: { stub_responses: true }

      expect(MediaItem.find_by(path: path)).not_to be_nil
    end
  end
end
