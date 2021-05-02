class Job < ApplicationRecord
  belongs_to :group
  belongs_to :agent
end
