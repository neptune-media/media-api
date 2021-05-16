# frozen_string_literal: true

class Job < ApplicationRecord
  has_many :tasks, dependent: :destroy
end
