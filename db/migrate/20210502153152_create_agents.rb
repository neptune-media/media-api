# frozen_string_literal: true

class CreateAgents < ActiveRecord::Migration[6.1]
  def change
    create_table :agents, id: :uuid do |t|
      t.string :media_server_type
      t.string :media_types
      t.string :job_types
      t.string :addr, null: false
      t.string :display_name
      t.uuid :access_key, null: false
      t.references :group, null: false, foreign_key: true, type: :uuid

      t.timestamps
    end
  end
end
