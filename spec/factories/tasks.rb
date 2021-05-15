# frozen_string_literal: true

FactoryBot.define do
  factory :task do
    job { build(:job) }

    factory :preview_task do
      data do
        {
          apiVersion: 'v1',
          kind: 'task',
          metadata: {},
          spec: {
            kind: 'previewTask'
          }
        }
      end
    end
  end
end
