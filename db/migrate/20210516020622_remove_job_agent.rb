# frozen_string_literal: true

class RemoveJobAgent < ActiveRecord::Migration[6.1]
  def change
    remove_column :jobs, :agent_id, type: :uuid
  end
end
