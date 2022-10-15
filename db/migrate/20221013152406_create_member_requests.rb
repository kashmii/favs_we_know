class CreateMemberRequests < ActiveRecord::Migration[6.0]
  def change
    create_table :member_requests do |t|
      t.references :room, foreign_key: true
      t.bigint :appricant_id

      t.timestamps
    end
    add_foreign_key :member_requests, :users, column: :appricant_id
  end
end
