# frozen_string_literal: true

require 'rails_helper'
require 'shared_examples/model_validations'

RSpec.describe Task, type: :model do
  subject { build(:preview_task) }

  include_examples 'model_validations'
end
