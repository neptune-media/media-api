# frozen_string_literal: true

require 'concerns/object_storage'

# ImportMediaWorker reads the metadata file for a media file, and
# records it to the database
class ImportMediaWorker
  include Sidekiq::Worker
  include ObjectStorage

  def perform(storage_backend_id, path, *_args)
    metadata = get_metadata storage_backend_id, path

    @media_item = MediaItem.find_or_create_by(
      storage_backend: storage_backend(storage_backend_id),
      path: path
    )

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

  def get_metadata(id, path)
    metadata_path = "#{path}.json"
    resp = client(id).get_object(bucket: @storage_backend.bucket, key: metadata_path)
    JSON.parse resp.body.read
  end
end
