class Agent < ApplicationRecord
  belongs_to :group
  has_many :jobs

  validates :access_key, :addr, :media_server_type, presence: true
end
