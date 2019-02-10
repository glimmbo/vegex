class TradesController < ApplicationController

  def index
    byebug
    p current_user
    trades = Trade.all.where(`user_id = #{current_user.id}`)
    render json: {
      trades: trades
    }, status: 200
  end

  def create
    trade = Trade.new
    trade.phase = "open"
    trade.user_id = current_user.id
    trade.produce = params[:produce]
    trade.quantity = params[:quantity]
    if trade.save
      render json: {
        id: trade.id
      }, status: 200
    else
      render json: {
        status: 422
      }, status: 422
    end
  end

  def update
    # quantity changes (by either)
    # offer_user enter/leave
    # 
  end

  def destroy
    
  end
end
