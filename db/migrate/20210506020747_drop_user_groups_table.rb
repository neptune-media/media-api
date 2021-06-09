# frozen_string_literal: true

class DropUserGroupsTable < ActiveRecord::Migration[6.1]
  def change
    drop_table :user_groups do |t|
      t.string :role
    end
  end
end
