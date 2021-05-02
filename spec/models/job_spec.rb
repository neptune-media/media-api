# frozen_string_literal: true

require 'rails_helper'
require 'shared_examples/model_validations'

RSpec.describe Job, type: :model do
  subject { build(:job) }

  include_examples 'model_validations'
end
