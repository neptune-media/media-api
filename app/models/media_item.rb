# frozen_string_literal: true

class MediaItem < ApplicationRecord
  belongs_to :storage_backend
end
