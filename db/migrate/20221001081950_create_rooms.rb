class CreateRooms < ActiveRecord::Migration[6.0]
  def change
    create_table :rooms do |t|
      t.string :name, null: false
      t.string :token

      t.timestamps
    end
    add_index :rooms, :token, unique: true
  end
end
