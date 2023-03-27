class AddColumnRooms < ActiveRecord::Migration[6.0]
  def change
    add_column :rooms, :founder_id, :bigint
    add_foreign_key :rooms, :users, column: :founder_id
  end
end
