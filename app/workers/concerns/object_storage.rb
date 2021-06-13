# frozen_string_literal: true

# Helper functions for working with different storage backends
module ObjectStorage
  attr_accessor :s3_client_opts

  def storage_backend(id)
    @storage_backend ||= StorageBackend.find id
  end

  def client(id)
    return @client unless @client.nil?

    opts = (@s3_client_opts || {}).dup
    opts.update({ endpoint: storage_backend(id).url }) if storage_backend(id).backend_type == 'minio'
    @client = Aws::S3::Client.new(
      credentials: storage_credentials(id),
      region: 'us-east-1',
      force_path_style: true,
      **opts
    )
  end

  def storage_credentials(id)
    @storage_credentials ||= Aws::Credentials.new(
      storage_backend(id).access_key,
      storage_backend(id).secret_key
    )
  end
end
