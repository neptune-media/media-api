# frozen_string_literal: true

module Api
  module V1
    module Exec
      # Handles agent task management
      class TasksController < ApplicationController
        def poll
          @tasks = agent_tasks
        end

        def acquire; end

        def release; end

        private

        def http_token
          @http_token ||= (request.headers['Authorization'].split.last if request.headers['Authorization'].present?)
        end

        def agent
          @agent ||= Agent.find_by access_key: http_token
        end

        def agent_tasks
          pending_tasks.where(agent: [nil, agent])
        end

        def pending_tasks
          Task.pending.task_kinds(agent&.job_types)
        end
      end
    end
  end
end
