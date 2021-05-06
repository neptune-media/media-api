# frozen_string_literal: true

FactoryBot.define do
  factory :storage_backend do
    bucket { 'test-bucket' }

    factory :minio_storage_backend do
      backend_type { 'minio' }
    end

    factory :s3_storage_backend do
      backend_type { 's3' }
    end
  end
end
