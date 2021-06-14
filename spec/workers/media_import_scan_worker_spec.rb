# frozen_string_literal: true

require 'rails_helper'

def create_stub_objects(client)
  client.stub_responses(
    :list_objects_v2,
    contents: [
      { key: 'foo.mkv' },
      { key: 'foo.mkv.json' }
    ]
  )
end

RSpec.describe MediaImportScanWorker, type: :worker do
  subject(:worker) do
    w = described_class.new
    w.s3_client_opts = s3_client_opts

    w
  end

  let(:storage_backend) { create(:minio_storage_backend) }
  let(:s3_client_opts) do
    {
      stub_responses: true
    }
  end

  describe '#bucket_objects' do
    it 'returns an array' do
      expect(worker.bucket_objects(storage_backend.id)).to be_a Array
    end
  end

  describe '#metadata_objects' do
    it 'returns an array' do
      create_stub_objects worker.client(storage_backend.id)

      expect(worker.metadata_objects(storage_backend.id)).to be_a Array
    end

    it 'has one object' do
      create_stub_objects worker.client(storage_backend.id)

      expect(worker.metadata_objects(storage_backend.id).length).to eq 1
    end
  end

  describe '#perform' do
    before do
      create_stub_objects worker.client(storage_backend.id)
    end

    it 'enqueues an ImportMediaWorker job' do
      allow(ImportMediaWorker).to receive(:perform_async)
      allow(worker.lock).to receive(:acquire!).and_return(true)
      allow(worker.lock).to receive(:release!).and_return(true)

      worker.perform storage_backend.id, s3_client_opts: { stub_responses: true }

      expect(ImportMediaWorker).to have_received(:perform_async).once
    end
  end
end
