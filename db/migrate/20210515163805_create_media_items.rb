# frozen_string_literal: true

class CreateMediaItems < ActiveRecord::Migration[6.1]
  def change
    create_table :media_items, id: :uuid do |t|
      t.references :storage_backend, null: false, foreign_key: true, type: :uuid
      t.string :path
      t.boolean :uploaded, null: false, default: false
      t.string :sha256
      t.jsonb :data, null: true

      t.timestamps
    end
  end
end
