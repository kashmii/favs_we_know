class MemberRequestsController < ApplicationController

  def create
    if current_user.request_allowed == true
      room_token = request_params.gsub('http://localhost:3000/rooms/', '')
      puts room_token
      room = Room.find_by(token: room_token)
      user = current_user
      request = MemberRequest.new(room_id: room.id, appricant_id: user.id)
      request.save
      user.update(request_allowed: false)
      # flash出す
      redirect_to about_path
    else
      puts 'nanimo sitenai'
    end
  end

  private

    def request_params
      params.require(:url)
    end

end
