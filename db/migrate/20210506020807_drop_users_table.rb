# frozen_string_literal: true

class DropUsersTable < ActiveRecord::Migration[6.1]
  def change
    drop_table :users do |t|
      t.string :username
      t.string :email
    end
  end
end
