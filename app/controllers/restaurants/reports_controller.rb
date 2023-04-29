class Restaurants::ReportsController < ApplicationController
  before_action :set_room, only: [:show, :create, :update, :destroy]
  before_action :set_restaurant, only: [:show, :new, :create]

  def show
    @report = Restaurant::Report.find(params[:id])
  end

  def new
    if !user_signed_in?
      session[:previous_url] = request.url
      redirect_to about_path
    else
      user = current_user
      @room = Room.find_by(id: user.room_id)
    end
    @report = Restaurant::Report.new(new_params)
  end

  def create
    @report = @restaurant.reports.build(report_params)
    @report.writer_id = current_user.id
    if @report.valid?
      @report.save!
      redirect_to restaurant_report_path(@restaurant, @report)
    else
      render :new
    end
  end

  def destroy
    report = Restaurant::Report.find(params[:id])
    report.destroy
    redirect_to room_path(@room.token), notice: "投稿を削除しました。"
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

  def set_restaurant
    @restaurant = Restaurant.find(params[:restaurant_id])

  end

  def report_params
    params.require(:restaurant_report).permit(
      :title, :score, :content, :restaurant_id
    )
  end
  
  def new_params  
    params.permit(
      :restaurant_id
    )
  end
end
