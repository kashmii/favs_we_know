class RoomSettingController < ApplicationController
  def index
    user = current_user
    @room = Room.find(user.room_id)

    @url = request.referer
  end
end
