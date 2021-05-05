# frozen_string_literal: true

class RemoveJobData < ActiveRecord::Migration[6.1]
  def change
    remove_column :jobs, :data, type: :jsonb
  end
end
