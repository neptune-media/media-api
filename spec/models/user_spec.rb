# frozen_string_literal: true

require 'rails_helper'
require 'shared_examples/model_validations'

RSpec.describe User, type: :model do
  subject { build(:user) }

  include_examples 'model_validations'
end
