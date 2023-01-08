class RoomsController < ApplicationController
  # before_action :get_user, only: [:new, :create]

  def new
    # もしuserのroom_idが埋まっていたら別のページに遷移させ、部屋を作らせない
    @room = Room.new
  end

  def create
    user = current_user
    @room = Room.new(room_params)
    if @room.save

      user.update(room_id: @room.id, is_founder: true)
      redirect_to room_url(token: @room.token)
    else
      redirect_to root_path
    end
  end

  def show
    # ログインしてなければ、まずログイン画面にリダイレクト
    if !user_signed_in?
      session[:previous_url] = request.url
      redirect_to about_path
    else
      user = current_user
      @room = Room.find_by(id: user.room_id)
    end
  end

  private

    def room_params
      params.require(:room).permit(:name)
    end

    # rspecでprivateメソッドを使えないようだったので、メソッド内に直接書くことにした
    # def get_user
    #   user = current_user
    # end
end
