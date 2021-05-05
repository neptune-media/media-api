# frozen_string_literal: true

module Api
  module V1
    class JobResource < JSONAPI::Resource
      attributes :params
      relationship :agents, to: :one
    end
  end
end
