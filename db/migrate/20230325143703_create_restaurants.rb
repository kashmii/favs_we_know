class CreateRestaurants < ActiveRecord::Migration[6.0]
  def change
    create_table :restaurants do |t|
      t.string :name, null: false
      t.string :genre, null: false
      t.string :place, null: false
      t.string :holiday
      t.string :url
      t.integer :tel
      t.references :room, foreign_key: true, null: false
      t.bigint :last_editor_id, null: false

      t.timestamps
    end
    add_foreign_key :restaurants, :users, column: :last_editor_id
  end
end
