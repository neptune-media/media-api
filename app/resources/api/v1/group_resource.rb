# frozen_string_literal: true

module Api
  module V1
    class GroupResource < JSONAPI::Resource
      attributes :name

      relationship :users, to: :many

      def self.records(options = {})
        context = options[:context]
        context[:current_user].groups
      end
    end
  end
end
