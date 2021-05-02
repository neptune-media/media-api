# frozen_string_literal: true

class StorageBackend < ApplicationRecord
  belongs_to :group

  validates :bucket, :prefix, :backend_type, presence: true
end
