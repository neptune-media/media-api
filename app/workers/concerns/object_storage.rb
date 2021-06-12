# frozen_string_literal: true

module ObjectStorage
  def client
    @client ||= Aws::S3::Client.new(
      credentials: storage_credentials,
      region: 'us-east-1',
      endpoint: @storage_backend.url,
      force_path_style: true
    )
  end

  def storage_credentials
    @storage_credentials ||= Aws::Credentials.new(
      @storage_backend.access_key,
      @storage_backend.secret_key
    )
  end
end
