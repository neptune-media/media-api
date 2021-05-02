class CreateJobs < ActiveRecord::Migration[6.1]
  def change
    create_table :jobs, id: :uuid do |t|
      t.string :type
      t.references :group, null: false, foreign_key: true, type: :uuid
      t.references :agent, null: false, foreign_key: true, type: :uuid
      t.jsonb :params

      t.timestamps
    end
  end
end
