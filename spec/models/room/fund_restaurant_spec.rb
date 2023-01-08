require 'rails_helper'

RSpec.describe Room, type: :model do
  
  # nameについて
  it 'nameがなければ登録できないこと' do
    restaurant = build(:room_fund_restaurant)
    restaurant.name = ''
    expect(restaurant).to_not be_valid
  end

  it 'nameは101文字では登録できないこと' do
    restaurant = build(:room_fund_restaurant)
    restaurant.name = 'a' * 101
    expect(restaurant).to_not be_valid
  end

end