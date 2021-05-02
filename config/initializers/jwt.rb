# frozen_string_literal: true

require 'json_web_token'

Rails.application.config.auth_token_issuer = ENV['AUTH_TOKEN_ISSUER'] || ENV['HOST'] || 'please.change.me'
Rails.application.config.jwt_shared_key = ENV['JWT_SHARED_KEY'] || ''
