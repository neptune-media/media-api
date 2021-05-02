# frozen_string_literal: true

require 'rails_helper'
require 'shared_examples/model_validations'

RSpec.describe TranscodeJob, type: :model do
  subject { build(:transcode_job) }

  include_examples 'model_validations'
end
