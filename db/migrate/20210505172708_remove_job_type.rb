# frozen_string_literal: true

class RemoveJobType < ActiveRecord::Migration[6.1]
  def change
    remove_column :jobs, :type, type: :string
  end
end
