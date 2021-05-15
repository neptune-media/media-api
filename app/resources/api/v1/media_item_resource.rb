# frozen_string_literal: true

module Api
  module V1
    class MediaItemResource < JSONAPI::Resource
      attributes :data, :path, :sha256, :uploaded
      relationship :storage_backend, to: :one
    end
  end
end
