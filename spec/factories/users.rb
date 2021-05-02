# frozen_string_literal: true

FactoryBot.define do
  factory :user do
    email { 'testuser@localhost' }
    password { 'foobar123' }
    username { 'testuser' }
  end
end
