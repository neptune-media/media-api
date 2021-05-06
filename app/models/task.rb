# frozen_string_literal: true

# A single unit of work
class Task < ApplicationRecord
  belongs_to :job
  belongs_to :agent

  validates :data, presence: true
  validate :valid_schema

  def json_schema_root
    Rails.root.join('app/models/schema/v1')
  end

  def json_schema_path(name)
    Pathname.new(json_schema_root.join(name).to_s)
  end

  def valid_schema
    @schema ||= JSONSchemer.schema(
      json_schema_path('task.json'),
      ref_resolver: proc { |uri| JSON.parse(json_schema_path(uri.path.to_s).read) }
    )
    @schema.validate(data).each { |e| handle_schema_error e }
  end

  # rubocop:disable Metrics/AbcSize, Metrics/MethodLength
  def handle_schema_error(error)
    case error['type']
    when 'const'
      field = error['data_pointer'][1..]
      value = error['data']
      expected = error['schema']['const']
      errors.add(:data, "invalid value for key \"#{field}\", expected \"#{expected}\", got \"#{value}\"")
    when 'oneOf'
      field = error['data_pointer'][1..]
      expected = error['schema']['oneOf']
      errors.add(:data, "expected \"#{field}\" to be one of \"#{expected.join(', ')}\"")
    when 'required'
      errors.add(:data, "missing required keys: #{error['details']['missing_keys'].join(', ')}")
    else
      errors.add(:data, error)
    end
  end
  # rubocop:enable Metrics/AbcSize, Metrics/MethodLength
end
