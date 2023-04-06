require 'rails_helper'

RSpec.describe "Users", type: :system do
  before do
    # Capybaraの影響で、これを書かないとステータスコードを取得できない
    driven_by(:rack_test)
  end

  describe 'ログインしていない場合' do
    context 'ログインしていない場合' do
      it 'ログインしていなければログイン中！は表示されていないこと' do
        visit root_path
        expect(page).to have_button 'ログイン'
        expect(page).to have_button '会員登録'
      end
    end
  end

  describe 'ページ遷移に関して' do
    context 'ログインしている場合' do
      it 'ログイン状態でログインページに行こうとするとホームに飛ばされる' do
        user = build(:user)
        sign_in user
        visit new_user_session_path
        expect(current_path).to eq root_path
      end

      it 'ログイン時にユーザー登録しようとしたらログイン画面にリダイレクトされるか' do
        user = build(:user)
        sign_in user
        visit new_user_registration_path
        expect(current_path).to eq root_path
      end
      
      it 'ログアウトしたらroot画面に遷移するか' do
        user = build(:user)
        sign_in user
        visit root_path
        click_button 'ログアウト'
        expect(current_path).to eq root_path
      end
    end
  end
end
