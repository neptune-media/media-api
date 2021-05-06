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
  subject { build(:agent) }

  include_examples 'model_validations'

  describe '#job_types' do
    let(:agent) { build(:agent, job_types: data) }
    let(:attr) { :job_types }

    include_examples 'array_attribute'
  end

  describe '#media_types' do
    let(:agent) { build(:agent, media_types: data) }
    let(:attr) { :media_types }

    include_examples 'array_attribute'
  end
end
