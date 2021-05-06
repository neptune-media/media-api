# frozen_string_literal: true

# Represent an agent and its capabilities
class Agent < ApplicationRecord
  has_many :jobs, dependent: :destroy

  validates :access_key, :addr, presence: true

  def job_types
    m = self[:job_types]
    m&.split(',')
  end

  def job_types=(value)
    self[:job_types] = (value.is_a?(Array) && value.join(',')) || value
  end

  def media_types
    m = self[:media_types]
    m&.split(',')
  end

  def media_types=(value)
    self[:media_types] = (value.is_a?(Array) && value.join(',')) || value
  end
end
