require 'rails_helper'

RSpec.describe "Users", type: :system do
  before do
    driven_by(:rack_test)
  end

  describe 'ページ遷移に関して' do
    context 'ログインしていない場合' do
      it 'ログインしていなければログイン中！は表示されていないこと' do
        visit root_path
    
        expect(page).to_not have_text 'ログイン中！'
      end
      
    end
    
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
      
      it 'ログイン後のルート画面でログイン中！の文字が表示されていること' do
        user = build(:user)
        sign_in user
        visit root_path
        expect(page).to have_text 'ログイン中！'
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