class Group < ApplicationRecord
  has_many :agents
  has_many :jobs
  has_many :storage_backends
  has_many :user_groups
  has_many :users, through: :user_groups
end
