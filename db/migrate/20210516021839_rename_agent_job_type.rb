# frozen_string_literal: true

class RenameAgentJobType < ActiveRecord::Migration[6.1]
  def change
    change_table :agents do |t|
      t.rename :task_types, :task_types
    end
  end
end
