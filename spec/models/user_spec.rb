require 'rails_helper'

RSpec.describe User, type: :model do
  # let(:user) {User.new(name: 'ExampleUser', email: 'user@example.com', password: 'foobar', password_confirmation: 'foobar')}

  it 'userが有効であること' do
    user = build(:user)
    expect(user).to be_valid
  end

  # nameについて
  it 'nameが必須であること' do
    user = build(:user)
    user.name = ''
    expect(user).to_not be_valid
  end

  it 'nameは40文字以内であること' do
    user = build(:user)
    user.name = 'a' * 41
    expect(user).to_not be_valid
  end
  
  it 'nameは2文字以上であること' do
    user = build(:user)
    user.name = 'a' * 1
    expect(user).to_not be_valid
  end

  # emailについて
  it 'emailが必須であること' do
    user = build(:user)
    user.email = ''
    expect(user).to_not be_valid
  end

  it 'emailは255文字以内であること' do
    user = build(:user)
    user.email = "#{'a' * 244}@example.com"
    expect(user).to_not be_valid
  end

  it 'emailが有効な形式であること' do
    user = build(:user)
    valid_addresses = %w[user@exmple.com USER@foo.COM A_US-ER@foo.bar.org first.last@foo.jp alice+bob@baz.cn]
    valid_addresses.each do |valid_address|
      user.email = valid_address
      expect(user).to be_valid
    end
  end

  it '無効な形式のemailは失敗すること' do
    invalid_addresses = %w[user@example,com user_at_foo.org user.name@example. foo@bar_baz.com foo@bar+baz.com]
    invalid_addresses.each do |invalid_address|
      user = build(:user)
      user.email = invalid_address
      expect(user).to_not be_valid
    end
  end

  it 'emailは重複して登録できないこと' do
    user = build(:user)
    duplicate_user = user.dup
    duplicate_user.email = user.email.upcase
    user.save
    expect(duplicate_user).to_not be_valid
  end

  # passwordについて
  it 'パスワードとconfirmationが違っていたらダメであること' do
    user = build(:user)
    user.password = 'foobarbar'
    expect(user).to_not be_valid
  end

  it 'passwordが必須であること' do
    user = build(:user)
    user.password = user.password_confirmation = '' * 6
    expect(user).to_not be_valid
  end
  
  it 'passwordが必須であること2' do
    user = build(:user)
    user.password = user.password_confirmation = 'a' * 6
    expect(user).to be_valid
  end

  it 'passwordが31文字以上だと登録できないこと' do
    user = build(:user)
    user.password = user.password_confirmation = 'a' * 31
    expect(user).to_not be_valid
  end

  describe 'ユーザー登録' do
    it "name、email、passwordとpassword_confirmationが存在すれば登録できること" do
      user = build(:user)
      expect(user).to be_valid
    end
  end
end