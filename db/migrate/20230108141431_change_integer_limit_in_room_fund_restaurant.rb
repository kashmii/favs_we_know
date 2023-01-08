class ChangeIntegerLimitInRoomFundRestaurant < ActiveRecord::Migration[6.0]
  def change
    change_column :room_fund_restaurants, :tel, :integer, limit: 5
  end
end
