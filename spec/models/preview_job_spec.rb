# frozen_string_literal: true

require 'rails_helper'
require 'shared_examples/model_validations'

RSpec.describe PreviewJob, type: :model do
  subject { build(:preview_job) }

  include_examples 'model_validations'
end
