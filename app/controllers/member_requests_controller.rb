class MemberRequestsController < ApplicationController
  before_action :set_request, only: %i(allow deny)
  before_action :get_user, only: %i(allow deny)

  def create
    if current_user.request_allowed == true
      get_user
      get_room_and_token
      request = MemberRequest.new(room_id: @room.id, appricant_id: @user.id)
      MemberRequest.transaction do

        request.save!
        # 部屋製作者を取得してnotificationテーブルのvisited_idに設定する
        # 消す
        room_founder = User.find_by(room_id: @room.id)
        room_founder.create_notification_member_request!(current_user, request)
        @user.update!(request_allowed: false)

      end
        # flash出す
      redirect_to about_path, notice: '入室申請しました'
    end
  end

  def destroy
    get_user
    request = MemberRequest.find_by(appricant_id: @user.id)
    MemberRequest.transaction do
      request.destroy
      # 紐付いている通知を削除
      @user.destroy_notification_member_request!(current_user)
      # userのrequestフラグをtrueにする！
      @user.update!(request_allowed: true)

    end
    redirect_to about_path, notice: '入室申請を取り消しました'
  end

  def allow
    @request.allowed!
    redirect_to notifications_path
  end

  def deny
    @request.denied!
    redirect_to notifications_path, notice: '接続を拒否しました'
  end

  private

    def get_user
      @user = current_user
    end

    def request_params
      params.require(:url)
    end

    def get_room_and_token
      if Rails.env.production?
        room_token = request_params.gsub('https://restaurants-we-know.herokuapp.com/rooms/', '')
      elsif Rails.env.development?
        room_token = request_params.gsub('http://localhost:3000/rooms/', '')
      end
      @room = Room.find_by(token: room_token)
    end

    def set_request
      @request = MemberRequest.find(params[:id])
    end
end
