class RenameJobParams < ActiveRecord::Migration[6.1]
  def change
    change_table :jobs do |t|
      t.rename :params, :data
    end
  end
end
