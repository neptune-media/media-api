# frozen_string_literal: true

FactoryBot.define do
  factory :agent do
    access_key { SecureRandom.uuid }
    addr { '127.0.0.1' }
    group { build(:group) }
  end
end
