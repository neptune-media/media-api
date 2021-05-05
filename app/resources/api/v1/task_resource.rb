# frozen_string_literal: true

module Api
  module V1
    class TaskResource < JSONAPI::Resource
      attributes :data
      relationship :agents, to: :one
      relationship :jobs, to: :one
    end
  end
end
