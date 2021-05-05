# frozen_string_literal: true

class CreateTasks < ActiveRecord::Migration[6.1]
  def change
    create_table :tasks, id: :uuid do |t|
      t.jsonb :data, null: false
      t.integer :state, null: false, default: 0
      t.references :job, null: false, foreign_key: true, type: :uuid
      t.references :agent, null: true, foreign_key: true, type: :uuid

      t.timestamps
    end
  end
end
