# frozen_string_literal: true

class CreateStorageBackends < ActiveRecord::Migration[6.1]
  def change
    create_table :storage_backends, id: :uuid do |t|
      t.string :url
      t.string :bucket
      t.string :prefix
      t.string :backend_type
      t.string :access_key
      t.string :secret_key
      t.references :group, null: false, foreign_key: true, type: :uuid

      t.timestamps
    end
  end
end
