# frozen_string_literal: true

require 'concerns/object_storage'

class MediaImportScanWorker
  include Sidekiq::Worker
  include ObjectStorage

  def perform(storage_backend_id, *_args)
    @storage_backend = StorageBackend.find storage_backend_id

    metadata_objects = bucket_objects.filter do |obj|
      obj.key.ends_with? '.json'
    end

    metadata_objects.each do |obj|
      path = obj.key.delete_suffix '.json'
      media_item = MediaItem.find_by storage_backend: @storage_backend, path: path

      # This is a new upload, enqueue the import job
      ImportMediaWorker.perform_async @storage_backend.id, path if media_item.nil?
    end
  end

  def bucket_objects
    resp = client.list_objects_v2({
                                    bucket: @storage_backend.bucket,
                                    prefix: @storage_backend.prefix
                                  })
    resp.contents
  end
end
