# frozen_string_literal: true

# Helper class for handling JWTs
class JsonWebToken
  def self.encode(payload)
    JWT.encode(payload, Rails.application.config.jwt_shared_key)
  end

  def self.decode(token)
    HashWithIndifferentAccess.new(JWT.decode(token, Rails.application.config.jwt_shared_key)[0])
  rescue StandardError
    nil
  end
end
