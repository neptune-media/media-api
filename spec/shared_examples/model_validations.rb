# frozen_string_literal: true

RSpec.shared_examples 'model_validations' do
  it 'validates successfully' do
    expect(subject).to be_valid
  end
end
