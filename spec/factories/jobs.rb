# frozen_string_literal: true

FactoryBot.define do
  factory :job do
    agent { build(:agent) }
  end
end
