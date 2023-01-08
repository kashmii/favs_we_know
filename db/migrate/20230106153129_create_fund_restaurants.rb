class CreateFundRestaurants < ActiveRecord::Migration[6.0]
  def change
    create_table :room_fund_restaurants do |t|
      t.string :name, null: false
      t.string :genre, null: false
      t.string :place, null: false
      t.string :holiday
      t.string :url
      t.integer :tel
      t.references :room, foreign_key: true
      t.bigint :last_editor_id

      t.timestamps
    end
    add_foreign_key :room_fund_restaurants, :users, column: :last_editor_id

    create_table :room_report_restaurants do |t|
      t.string :title, null: false
      t.integer :score, null: false
      t.string :content, null: false
      t.references :room_fund_restaurants, foreign_key: true
      t.references :users, foreign_key: true

      t.timestamps
    end

    create_table :room_comments do |t|
      t.string :content, null: false
      t.references :room_report_restaurants, foreign_key: true
      t.references :users, foreign_key: true

      t.timestamps
    end
  end
end

