# frozen_string_literal: true

class RemoveJobType < ActiveRecord::Migration[6.1]
  def change
    change_table :jobs do |t|
      t.remove :type
    end
  end
end
