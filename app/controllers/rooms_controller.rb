class RoomsController < ApplicationController
  before_action :set_user, only: [:new, :show, :create]

  def new
    # もしuserのroom_idが埋まっていたら別のページに遷移させ、部屋を作らせない
    @room = Room.new
  end

  def create
    @room = Room.new(room_params)
    Room.transaction do
      if @room.save!
        @user.update!(room_id: @room.id)
        RoomFounder.create!(room_id: @room.id, founder_id: @user.id)
        redirect_to room_url(token: @room.token)
      else
        redirect_to root_path
      end
    end
  end

  def show
    # ログインしてなければ、まずログイン画面にリダイレクト
    if !user_signed_in?
      session[:previous_url] = request.url
      redirect_to about_path
    else
      @room = @user.room
    end
    @restaurants = Room::Restaurant.all
  end

  private

    def room_params
      params.require(:room).permit(:name)
    end

    # rspecでprivateメソッドを使えないようだったので、メソッド内に直接書くことにした
    def set_user
      @user = current_user
    end
end
