# frozen_string_literal: true

class Group < ApplicationRecord
  has_many :agents, dependent: :destroy
  has_many :jobs, dependent: :destroy
  has_many :storage_backends, dependent: :destroy
  has_many :user_groups, dependent: :destroy
  has_many :users, through: :user_groups

  validates :name, presence: true
end
