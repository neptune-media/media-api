# frozen_string_literal: true

class Job < ApplicationRecord
  belongs_to :group
  belongs_to :agent

  validates :params, presence: true
end
