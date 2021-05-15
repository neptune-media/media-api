# frozen_string_literal: true

class InvalidTaskStateError < StandardError; end

# A single unit of work
class Task < ApplicationRecord
  belongs_to :job
  belongs_to :agent, optional: true

  enum state: {
    created: 0,
    pending: 1,
    acquired: 2,
    running: 3,
    paused: 4,
    finished: 5,
    failed: 6
  }

  validates :data, presence: true
  validate :valid_schema

  def self.task_kind(kind)
    where("data -> 'spec' -> 'kind' ? :kind", kind: kind)
  end

  def self.task_kinds(kinds)
    return where(nil) if kinds.blank?

    partial = task_kind kinds.shift
    kinds.each do |kind|
      partial = partial.or task_kind(kind)
    end

    partial
  end

  def acquire(agent)
    self.agent = agent
    self.state = :acquired
    self
  end

  def acquire!(agent)
    acquire(agent).save!
  end

  def json_schema_root
    Rails.root.join('app/models/schema/v1')
  end

  def json_schema_path(name)
    Pathname.new(json_schema_root.join(name).to_s)
  end

  def release(success: false)
    case state
    when 'acquired'
      self.state = :pending
      self.agent = nil unless preassigned?
    when 'running'
      self.state = if success
                     :finished
                   else
                     :failed
                   end
    else
      raise InvalidTaskStateError
    end

    self
  end

  def release!(success: false)
    release(success: success).save!
  end

  def task_kind
    data['spec']['kind']
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
