class CreateRoomFounders < ActiveRecord::Migration[6.0]
  def change
    create_table :room_founders do |t|
      t.bigint :founder_id, index: true, null: false
      t.references :room, foreign_key: true, null: false

      t.timestamps
    end
    add_foreign_key :room_founders, :users, column: :founder_id
  end
end
