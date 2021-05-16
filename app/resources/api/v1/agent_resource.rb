# frozen_string_literal: true

module Api
  module V1
    # JSONAPI resource for the Agent model
    class AgentResource < JSONAPI::Resource
      attributes :addr, :display_name, :job_types, :media_server_type, :media_types

      relationship :tasks, to: :many

      def self.updatable_fields(context)
        super

        [:display_name]
      end
    end
  end
end
