class CreateNotifications < ActiveRecord::Migration[6.0]
  def change
    create_table :member_requests do |t|
      t.references :room, foreign_key: true, null: false
      t.bigint :appricant_id, null: false
      t.integer :status, null: false

      t.timestamps
    end
    add_foreign_key :member_requests, :users, column: :appricant_id

    create_table :notifications do |t|
      t.integer :visitor_id, null: false
      t.integer :visited_id, null: false
      t.string :action, null: false
      t.references :member_request, foreign_key: true
      t.references :room_report, foreign_key: true
      t.boolean :checked, null: false, default: false

      t.timestamps
    end
  end
end
