# frozen_string_literal: true

module Api
  module V1
    module Exec
      # Handles agent task management
      class TasksController < ApplicationController
        before_action :require_agent
        before_action :load_task, except: :poll

        def acquire
          return render plain: 'Task is in invalid state', status: :bad_request unless @task.state == 'pending'

          @task.acquire! agent
        end

        def poll
          @tasks = agent_tasks
        end

        def release
          @task.release! success: params['success']
          @task.save!
        rescue InvalidTaskStateError
          render plain: 'Task is in invalid state', status: :bad_request
        end

        def update
          task_params = params.permit(:state)
          @task.update!(task_params)
          head :no_content
        end

        private

        def load_task
          @task = Task.find params['id']
          render plain: 'Not Found', status: :not_found if @task.nil?
        end

        def require_agent
          render plain: 'Missing access key', status: :bad_request if agent.nil?
        end

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
