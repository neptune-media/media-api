# frozen_string_literal: true

require 'rails_helper'
require 'shared_examples/model_validations'

RSpec.describe Agent, type: :model do
  subject { build(:agent) }

  include_examples 'model_validations'
end
