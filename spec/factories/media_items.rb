# frozen_string_literal: true

FactoryBot.define do
  factory :media_item do
    storage_backend { build(:storage_backend) }
    path { 'foo' }
    uploaded { false }
  end
end
