require 'rails_helper'

RSpec.describe "Posts", type: :request do
  describe "GET /posts" do
    before do
      #factory_botを利用して認証モデルを作成します。
      @user = create(:user)
    end

    it "works! (now write some real specs)" do
      #認証処理を行います
      sign_in @user
      get root_path
      expect(response).to have_http_status(200)
    end
  end
end