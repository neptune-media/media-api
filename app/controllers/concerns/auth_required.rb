# frozen_string_literal: true

module AuthRequired
  extend ActiveSupport::Concern

  included do
    before_action :authenticate_request!
  end
end
