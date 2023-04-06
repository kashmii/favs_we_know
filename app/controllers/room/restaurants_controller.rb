class Room::RestaurantsController < ApplicationController
  before_action :set_room, only: [:show, :create, :update]

  # 部屋の権限を確かめるコードを書く
  # before_action :set_company

  def show
    @restaurant = Room::Restaurant.find(params[:id])
  end

  def new
    if !user_signed_in?
      session[:previous_url] = request.url
      redirect_to about_path
    else
      user = current_user
      @room = Room.find_by(id: user.room_id)
    end
    @restaurant = Room::Restaurant.new
    # render 'new'
  end

  def create
    @restaurant = Room::Restaurant.new(restaurant_params)
    @restaurant.room_id = current_user.room_id
    @restaurant.last_editor_id = current_user.id
    @restaurant.save!
  end

  def destroy
  end

  private

  def set_room
    if !user_signed_in?
      session[:previous_url] = request.url
      redirect_to about_path
    else
      user = current_user
      @room = Room.find_by(id: user.room_id)
    end
  end

  def restaurant_params
    params.require(:room_restaurant).permit(
      :name,
      :genre,
      :place,
      :holiday,
      :url,
      :tel
    )
  end
end
