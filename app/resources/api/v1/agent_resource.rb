# frozen_string_literal: true

module Api
  module V1
    class AgentResource < JSONAPI::Resource
      attributes :addr, :display_name, :job_types, :media_server_type, :media_types

      relationship :tasks, to: :many
      relationship :groups, to: :one
    end
  end
end
