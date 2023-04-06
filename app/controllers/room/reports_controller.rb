class Room::ReportsController < ApplicationController
  before_action :set_room, only: [:show, :create, :update]

  # 部屋の権限を確かめるコードを書く
  # before_action :set_company

  def show
    @restaurant = FundRestaurant::Report.find(params[:id])
  end

  def new
    if !user_signed_in?
      session[:previous_url] = request.url
      redirect_to about_path
    else
      user = current_user
      @room = Room.find_by(id: user.room_id)
    end
    @report = FundRestaurant::Report.new(new_params)
    puts @report.room_fund_restaurant_id
    # puts @report.present?
    puts "====="
    render 'new'
  end

  def create
    @report = FundRestaurant::Report.new(report_params)
    puts params[:fund_restaurant_id]
    @report.room_fund_restaurant_id = params[:fund_restaurant_id].to_i
    @report.user_id = current_user.id
    puts @report.user_id
    puts @report.room_fund_restaurant_id
    @report.save!
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
    params.require(:fund_restaurant_report).permit(
      :title, :score, :content, :room_fund_restaurant_id
    )
  end
  
  def new_params
    params.permit(
      :room_fund_restaurant_id
    )
  end
end
