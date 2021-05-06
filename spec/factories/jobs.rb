# frozen_string_literal: true

FactoryBot.define do
  factory :job do
    group { build(:group) }
    agent { build(:agent) }
  end
end
