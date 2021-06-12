# frozen_string_literal: true

require 'rails_helper'
require 'shared_examples/model_validations'

RSpec.shared_examples 'array_attribute' do
  describe 'nil' do
    let(:data) { nil }

    it { expect(agent.send(attr)).to be_nil }
  end

  describe 'one item' do
    let(:data) { 'foo' }

    it { expect(agent.send(attr)).to be_a Array }
    it { expect(agent.send(attr).length).to eq 1 }
  end

  describe 'two items' do
    let(:data) { %w[foo bar] }

    it { expect(agent.send(attr)).to be_a Array }
    it { expect(agent.send(attr).length).to eq 2 }
  end
end

RSpec.describe Agent, type: :model do
  subject(:agent) { build(:agent) }

  include_examples 'model_validations'

  describe '#can_exec_task_type?' do
    subject(:agent) { build(:preview_agent) }

    it 'returns false' do
      expect(agent).not_to be_can_exec_task_type('transcodeJob')
    end

    it 'returns true' do
      expect(agent).to be_can_exec_task_type('previewJob')
    end
  end

  describe '#task_types' do
    subject(:agent) { build(:agent, task_types: data) }

    let(:attr) { :task_types }

    include_examples 'array_attribute'
  end

  describe '#media_types' do
    subject(:agent) { build(:agent, media_types: data) }

    let(:attr) { :media_types }

    include_examples 'array_attribute'
  end
end
