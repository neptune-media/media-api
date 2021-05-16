# frozen_string_literal: true

require 'rails_helper'
require 'shared_examples/model_validations'

RSpec.describe MediaItem, type: :model do
  subject { build(:media_item) }

  include_examples 'model_validations'
end
