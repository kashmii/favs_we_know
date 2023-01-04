class MemberRequestsController < ApplicationController

  def create
    if current_user.request_allowed == true
      get_user
      get_room_and_token
      request = MemberRequest.new(room_id: @room.id, appricant_id: @user.id)
      MemberRequest.transaction do

        request.save!
        # 部屋製作者を取得してnotificationテーブルのvisited_idに設定する
        room_founder = User.find_by(room_id: @room.id, is_founder: true)
        room_founder.create_notification_member_request!(current_user)
        @user.update!(request_allowed: false)

      end
        # flash出す
      redirect_to about_path, notice: '入室申請しました'
    else
      puts 'nanimo sitenai'
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

  private

    def get_user
      @user = current_user
    end

    def request_params
      params.require(:url)
    end

    def get_room_and_token
      room_token = request_params.gsub('http://localhost:3000/rooms/', '')
      puts room_token
      @room = Room.find_by(token: room_token)
    end
end
