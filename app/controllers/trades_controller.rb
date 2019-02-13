class TradesController < ApplicationController

  def index # offers page
    trades = Trade.where({user_id: !current_user.id, aasm_state: [:open, :barter]})
    render json: {
      trades: trades
    }, status: 200
  end

  def my # active trades
    trades = Trade.where({user_id: current_user.id, aasm_state: [:open, :barter, :pending]})
    render json: {
      trades: trades
    }, status: 200
  end

  def create
    trade = Trade.new
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
    # separate actions for:
    # quantity changes (by either)
    # offer_user enter/leave
    # 
  end

  def destroy
    
  end
end
