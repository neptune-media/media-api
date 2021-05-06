# frozen_string_literal: true

module Api
  module V1
    module Exec
      class AgentsController < ApplicationController
        def register
          @agent = agent_from_payload params
        end

        private

        def agent_from_payload(payload)
          addr = payload[:addr]
          agent_id = payload[:id]
          agent = Agent.find_or_create_by(id: agent_id)
          agent.addr = addr
          agent.access_key = SecureRandom.uuid if agent.access_key.nil?
          agent.save!

          agent
        end
      end
    end
  end
end
