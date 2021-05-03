# frozen_string_literal: true

JSONAPI.configure do |config|
  config.resource_cache = Rails.cache
  # config.default_caching = true

  #:integer, :uuid, :string, or custom (provide a proc)
  config.resource_key_type = :uuid

  # Options are :none, :offset, :paged, or a custom paginator name
  config.default_paginator = :offset # default is :none

  config.default_page_size = 50 # default is 10
  config.maximum_page_size = 100 # default is 20
end
