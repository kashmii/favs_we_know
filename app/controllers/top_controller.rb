# rootのコントローラ
class TopController < ApplicationController
  before_action :get_user

  def index
    # ログインしていて、部屋作成済み：部屋画面へ
    if user_signed_in? && @user.room_id.present?
      puts "====="
      puts @user.room_id
      @room = Room.find(@user.room_id)
      redirect_to room_url(token: @room.token)
    end
  end

  def about
    # リクエスト申請済だったら、ビューにmember_requestsの変数を渡す
    if @user != nil && @user.request_allowed == false
      @member_requests = MemberRequest.find_by(appricant_id: @user.id)
    end
  end

  private

    def get_user
      @user = current_user
    end  
end
