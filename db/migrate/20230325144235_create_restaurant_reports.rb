class CreateRestaurantReports < ActiveRecord::Migration[6.0]
  def change
    create_table :restaurant_reports do |t|
      t.string :title, null: false
      t.integer :score
      t.string :content, null: false
      t.references :restaurant, foreign_key: true, null: false
      t.bigint :writer_id, null: false

      t.timestamps
    end
    add_foreign_key :restaurant_reports, :users, column: :writer_id
  end
end
