# frozen_string_literal: true

module Api
  module V1
    class ApiController < ApplicationController
      include JSONAPI::ActsAsResourceController
      include AuthRequired

      def context
        {
          current_user: current_user
        }
      end
    end
  end
end
