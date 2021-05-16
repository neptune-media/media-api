# frozen_string_literal: true

module Api
  module V1
    class StorageBackendResource < JSONAPI::Resource
      attributes :backend_type, :bucket, :prefix
    end
  end
end
