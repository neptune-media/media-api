# frozen_string_literal: true

require 'rails_helper'

class Foo
  include ObjectStorage
end

RSpec.describe ObjectStorage, type: :concern do
  subject(:worker) { Foo.new }

  let(:storage_backend) { create(:minio_storage_backend) }

  describe '#client' do
    it 'returns a Aws::S3::Client' do
      expect(worker.client(storage_backend.id)).to be_a Aws::S3::Client
    end
  end

  describe '#storage_backend' do
    it 'returns a StorageBackend' do
      expect(worker.storage_backend(storage_backend.id)).to be_a StorageBackend
    end
  end

  describe '#storage_credentials' do
    it 'returns a Aws::Credentials' do
      expect(worker.storage_credentials(storage_backend.id)).to be_a Aws::Credentials
    end
  end
end
