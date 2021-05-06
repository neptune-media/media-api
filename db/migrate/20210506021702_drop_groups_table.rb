# frozen_string_literal: true

class DropGroupsTable < ActiveRecord::Migration[6.1]
  def change
    drop_table :groups do |t|
      t.string :name
    end
  end
end
