class CreateUserGroups < ActiveRecord::Migration[6.1]
  def change
    create_table :user_groups, id: :uuid do |t|
      t.string :role
      t.references :user, null: false, foreign_key: true, type: :uuid
      t.references :group, null: false, foreign_key: true, type: :uuid

      t.timestamps

      t.index [:user_id, :group_id], unique: true
    end
  end
end
