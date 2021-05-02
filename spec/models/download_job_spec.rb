# frozen_string_literal: true

require 'rails_helper'
require 'shared_examples/model_validations'

RSpec.describe DownloadJob, type: :model do
  subject { build(:download_job) }

  include_examples 'model_validations'
end
