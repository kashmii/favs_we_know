class AddDetailsToUsers < ActiveRecord::Migration[6.0]
  def change
    add_column :users, :is_founder, :boolean, default: false
    add_column :users, :request_allowed, :boolean, default: true
  end
end
