# frozen_string_literal: true

module Api
  module V1
    module Exec
      # Handles agent management
      class AgentsController < ApplicationController
        def register
          @agent = agent_from_payload agent_params
        end

        private

        def agent_params
          params.permit(:id, :addr, :media_server_type, media_types: [], task_types: [])
        end

        def agent_from_payload(payload)
          addr = payload[:addr]
          id = payload[:id]
          agent = Agent.find_or_create_by(id: id)
          agent.addr = addr
          agent.access_key = SecureRandom.uuid if agent.access_key.nil?
          agent.save!

          update_agent_attributes(agent, payload)
        end

        def update_agent_attributes(agent, payload)
          attributes = payload.reject { |k, _| [:id, :addr, :access_key].include? k.to_sym }.compact
          agent.update(attributes)

          agent
        end
      end
    end
  end
end
