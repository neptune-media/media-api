# frozen_string_literal: true

json.array! @tasks, partial: 'api/v1/exec/tasks/task', as: :task
