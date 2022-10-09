require 'rails_helper'

RSpec.describe Room, type: :model do
  
  # nameについて
  it 'nameがなければ登録できないこと' do
    room = build(:room)
    room.name = ''
    expect(room).to_not be_valid
  end
  
  it 'nameは1文字では登録できないこと' do
    room = build(:room)
    room.name = 'a'
    expect(room).to_not be_valid
  end

  it 'nameは41文字では登録できないこと' do
    room = build(:room)
    room.name = 'a' * 41
    expect(room).to_not be_valid
  end

end