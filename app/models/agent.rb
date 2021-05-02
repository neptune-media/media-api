class Agent < ApplicationRecord
  belongs_to :group
  has_many :jobs
end
