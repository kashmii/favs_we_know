class Restaurants::ReportsController < ApplicationController
  before_action :set_room, only: [:show, :create, :update]

  def show
    @restaurant = Restaurant::Report.find(params[:id])
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
    @report = Restaurant::Report.new(report_params)
    @report.restaurant_id = params[:restaurant_id].to_i
    @report.writer_id = current_user.id
    @report.save!
    redirect_to restaurant_report_path(@report.restaurant_id, @report.id)
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
