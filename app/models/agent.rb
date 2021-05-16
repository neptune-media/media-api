# frozen_string_literal: true

# Represent an agent and its capabilities
class Agent < ApplicationRecord
  has_many :tasks, dependent: :destroy

  validates :access_key, :addr, presence: true

  def can_exec_task_type?(type)
    task_types&.include?(type) || false
  end

  def task_types
    m = self[:task_types]
    m&.split(',')
  end

  def task_types=(value)
    self[:task_types] = (value.is_a?(Array) && value.join(',')) || value
  end

  def media_types
    m = self[:media_types]
    m&.split(',')
  end

  def media_types=(value)
    self[:media_types] = (value.is_a?(Array) && value.join(',')) || value
  end
end
