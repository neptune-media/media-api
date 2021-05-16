# frozen_string_literal: true

module Api
  module V1
    class TaskResource < JSONAPI::Resource
      attributes :data
      relationship :agent, to: :one
      relationship :job, to: :one
    end
  end
end
