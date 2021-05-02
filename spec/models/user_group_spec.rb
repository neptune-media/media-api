# frozen_string_literal: true

require 'rails_helper'
require 'shared_examples/model_validations'

RSpec.describe UserGroup, type: :model do
  subject { build(:user_group) }

  include_examples 'model_validations'
end
