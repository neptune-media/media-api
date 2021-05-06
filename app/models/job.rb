# frozen_string_literal: true

class Job < ApplicationRecord
  belongs_to :agent
  has_many :tasks, dependent: :destroy
end
