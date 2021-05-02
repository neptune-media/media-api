# frozen_string_literal: true

require 'rails_helper'
require 'shared_examples/model_validations'

RSpec.describe Group, type: :model do
  subject { build(:group) }

  include_examples 'model_validations'
end
