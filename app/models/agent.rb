# frozen_string_literal: true

class Agent < ApplicationRecord
  has_many :jobs, dependent: :destroy

  validates :access_key, :addr, presence: true
end
