# frozen_string_literal: true

require 'rails_helper'
require 'shared_examples/model_validations'

RSpec.describe Task, type: :model do
  subject(:task) { build(:preview_task) }

  include_examples 'model_validations'

  describe '.task_kind' do
    it 'returns a task' do
      create(:preview_task)
      expect(described_class.task_kind('previewTask').count).to eq 1
    end

    it 'returns nil' do
      create(:preview_task)
      expect(described_class.task_kind('transcodeTask').count).to eq 0
    end
  end

  describe '.task_kinds' do
    it 'returns an ActiveRecord::Relation' do
      create(:preview_task)
      expect(described_class.task_kinds([]).count).to eq 1
    end

    it 'returns a task' do
      create(:preview_task)
      expect(described_class.task_kinds(%w[previewTask transcodeTask]).count).to eq 1
    end
  end

  describe '#task_kind' do
    it 'returns previewTask' do
      expect(task.task_kind).to eq 'previewTask'
    end
  end
end
