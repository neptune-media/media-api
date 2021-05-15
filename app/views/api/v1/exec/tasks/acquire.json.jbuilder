# frozen_string_literal: true

json.partial! 'api/v1/exec/tasks/task', task: @task
json.extract! @task, :data
