# frozen_string_literal: true

class StorageBackend < ApplicationRecord
  has_kms_key

  belongs_to :group

  validates :bucket, :backend_type, presence: true

  encrypts :access_key, key: :kms_key
  encrypts :secret_key, key: :kms_key
end
