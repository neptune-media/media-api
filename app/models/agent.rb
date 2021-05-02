# frozen_string_literal: true

class Agent < ApplicationRecord
  belongs_to :group
  has_many :jobs, dependent: :destroy

  validates :access_key, :addr, presence: true
end
