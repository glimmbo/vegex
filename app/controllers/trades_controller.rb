class TradesController < ApplicationController
  # before_action :authenticate_user!

  def index # open trades
    
    if params[:search] #need to make form that does GET with params[:search]
      trades = Trade.available.where(["produce ILIKE ? and user_id != ?", params[:search], current_user.id])
    else
      trades = Trade.available.where.not(user_id: current_user.id).order(:produce)
    end

    trades = trades.map do |trade|
      trade = {
        id: trade.id,
        produce: trade.produce,
        distance: trade.user.distance_to(current_user, :km).round(1),
        user_name: trade.user.name,
        completion: trade.user.completion
      }
    end
    
    render json: {
      trades: trades
    }, status: 200
  end

  def show # trade room
    trade = Trade.find(params[:id])
    partner = User.find(trade.offer_user_id)

    render json: {
      trade: trade,
      partner: partner
    }, status: 200
  end

  def my # active trades
    trades = Trade
      .where({user_id: current_user.id, aasm_state: [:open, :barter, :pending]})
      .as_json(include: {offers: {include: :user}})
    
    offers_made = Offer
      .where({user_id: current_user.id}, aasm_state: [:pending])
      .as_json(include: {trade: {include: :user}})

    render json: {
      trades: trades,
      offers_made: offers_made
    }, status: 200
  end

  def create # √ √
    if current_user.slot_available
      trade = Trade.new
      trade.user_id = current_user.id
      trade.produce = trade_params[:produce]
      if trade.save
        render json: {
          trade: trade
        }, status: 200
      else
        render json: {
          status: 422
        }, status: 422
      end
    else
      render json: {
        errors: ["You don't have any available slots to open a new trade."]
      }, status: 400
    end
  end

  def update # trade room actions
    # owner cancels
      # TODO
    # quantity changes (by either)
      # TODO
    # offer_user enter/leave
    trade = Trade.find(trade_params[:id])
    if trade_params[:owner_cancel]
      if trade.cancel?
        respond json: {status: 200}
      end
    elsif trade_params[:quantities]
      # trade.quantity = trade_params[:quantities[:owner]]
      # trade.offer_quantity = trade_params[:quantities[:offerer]]
      # if trade.save
      #   render json: {status: 200}
      # end
    elsif trade_params[:accept]
      trade.offer_user_id = trade_params[:accept][:offer_id]
      trade.offer_produce = Offer.find(trade_params[:accept][:offer_id]).produce
      trade.enter
      if trade.save
        render json: {status: 200}, status: 200
      end
    end


  end

  def destroy
    trade = Trade.find(trade_params.id)
    if trade.cancel
      # remove offerer?
      render json: {status: 200}
    elsif trade.fail
      # trade.user.completion = 
      # how to let partner know?
      render json: {status: 200}
    else
      render json: {status: 500}
    end
  end

  private
  def trade_params
    params.require(:trade).permit!
  end

  def search_params
    params.require(:search).permit!
  end

end
