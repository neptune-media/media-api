# frozen_string_literal: true

FactoryBot.define do
  factory :user_group do
    user { build(:user) }
    group { build(:group) }
    role { 'owner' }
  end
end
