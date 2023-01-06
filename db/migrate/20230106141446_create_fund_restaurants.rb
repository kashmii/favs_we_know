class CreateFundRestaurants < ActiveRecord::Migration[6.0]
  def change
    create_table :fund_restaurants do |t|
      t.string :name
      t.string :genre
      t.integer :tel
      t.string :holiday
      t.string :url
      t.string :place
      t.integer :last_editor_id
      t.references :room, foreign_key: true

      t.timestamps
    end
    add_foreign_key :fund_restaurants, :users, column: :last_editor_id
  end
end
