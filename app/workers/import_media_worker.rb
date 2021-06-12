# frozen_string_literal: true

require 'concerns/object_storage'

class ImportMediaWorker
  include Sidekiq::Worker
  include ObjectStorage

  def perform(storage_backend_id, path, *_args)
    @storage_backend = StorageBackend.find storage_backend_id
    @media_item = MediaItem.find_or_create_by(
      storage_backend: @storage_backend,
      path: path
    )

    metadata = get_metadata path
    @media_item.update!(parse_metadata(metadata))
  end

  def parse_metadata(metadata)
    {
      sha256: metadata['sha256'],
      uploaded: true,
      data: {
        import_path: metadata['import_path']
      }
    }
  end

  def get_metadata(path)
    metadata_path = "#{path}.json"
    resp = client.get_object(bucket: @storage_backend.bucket, key: metadata_path)
    JSON.parse resp.body.read
  end
end
