class RoomsController < ApplicationController
  before_action :get_user, only: [:new, :create]

  def new
    # もしuserのroom_idが埋まっていたら別のページに遷移させ、部屋を作らせない
    @room = Room.new
  end

  def create
    @room = Room.new(room_params)
    
    if @room.save
      @user.update(room_id: @room.id)
      redirect_to room_url(token: @room.token)
    else
      redirect_to root_path
    end
  end

  def show
    @room = Room.find_by(token: params[:token])
  end

  private

    def room_params
      params.require(:room).permit(:name)
    end

    def get_user
      @user = current_user
    end
end
