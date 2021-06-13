# frozen_string_literal: true

require 'concerns/object_storage'

# MediaImportScanWorker reads the specified storage backend, looking
# for new files not in the database
class MediaImportScanWorker
  include Sidekiq::Worker
  include Sidekiq::Lock::Worker
  include ObjectStorage

  sidekiq_options lock: { timeout: 30_000, name: 'MediaImportScanWorker' }

  def perform(storage_backend_id, *_args, s3_client_opts: {})
    @s3_client_opts = s3_client_opts
    return unless lock.acquire!

    begin
      metadata_objects(storage_backend_id).each do |obj|
        path = obj.key.delete_suffix '.json'
        media_item = MediaItem.find_by storage_backend_id: storage_backend_id, path: path

        # This is a new upload, enqueue the import job
        ImportMediaWorker.perform_async storage_backend_id, path if media_item.nil?
      end
    ensure
      lock.release!
    end
  end

  def bucket_objects(id)
    resp = client(id).list_objects_v2({
                                        bucket: storage_backend(id).bucket,
                                        prefix: storage_backend(id).prefix
                                      })
    resp.contents
  end

  def metadata_objects(id)
    bucket_objects(id).filter do |obj|
      obj.key.ends_with? '.json'
    end
  end
end
