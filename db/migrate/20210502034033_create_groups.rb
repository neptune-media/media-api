class CreateGroups < ActiveRecord::Migration[6.1]
  def change
    create_table :groups, id: :uuid do |t|
      t.string :name

      t.timestamps
    end

    add_index :groups, :name, unique: true
  end
end
