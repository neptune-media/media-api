# frozen_string_literal: true

class AddTaskPreassigned < ActiveRecord::Migration[6.1]
  def change
    change_table :tasks do |t|
      t.boolean :preassigned
    end
  end
end
