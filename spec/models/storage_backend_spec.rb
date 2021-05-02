# frozen_string_literal: true

require 'rails_helper'
require 'shared_examples/model_validations'

RSpec.describe StorageBackend, type: :model do
  describe 'with minio' do
    subject { build(:minio_storage_backend) }

    include_examples 'model_validations'
  end

  describe 'with s3' do
    subject { build(:s3_storage_backend) }

    include_examples 'model_validations'
  end
end
