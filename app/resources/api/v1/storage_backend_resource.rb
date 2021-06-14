# frozen_string_literal: true

module Api
  module V1
    # Represents a StorageBackend model
    class StorageBackendResource < JSONAPI::Resource
      WRITE_ONLY_FIELDS = [:access_key, :secret_key].freeze

      attributes :backend_type, :bucket, :prefix, :url, :access_key, :secret_key

      def fetchable_fields
        super - WRITE_ONLY_FIELDS
      end
    end
  end
end
