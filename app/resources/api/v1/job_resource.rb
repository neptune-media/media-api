# frozen_string_literal: true

module Api
  module V1
    class JobResource < JSONAPI::Resource
      relationship :groups, to: :one
      relationship :tasks, to: :many
    end
  end
end
