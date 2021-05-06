# frozen_string_literal: true

class DropUserGroupsTable < ActiveRecord::Migration[6.1]
  def change
    remove_column :agents, :group_id, type: :uuid
    remove_column :jobs, :group_id, type: :uuid
    remove_column :storage_backends, :group_id, type: :uuid
    drop_table :user_groups do |t|
      t.string :role
    end
  end
end
