class MemberRequestsController < ApplicationController

  def create
    if current_user.request_allowed == true
      get_room_and_token
      request = MemberRequest.new(room_id: @room.id, appricant_id: @user.id)
      request.save
      @user.update(request_allowed: false)
      # flash出す
      redirect_to about_path, notice: '入室申請しました'
    else
      puts 'nanimo sitenai'
    end
  end

  def destroy
    get_room_and_token
    request = MemberRequest.find_by(appricant_id: @user.id)
    request.destroy
    redirect_to about_path, notice: '入室申請を取り消しました'
  end

  private

    def request_params
      params.require(:url)
    end

    def get_room_and_token
      room_token = request_params.gsub('http://localhost:3000/rooms/', '')
      puts room_token
      @room = Room.find_by(token: room_token)
      @user = current_user
    end
end
