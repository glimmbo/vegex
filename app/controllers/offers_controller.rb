class OffersController < ApplicationController

  def create # make an offer
    if current_user.slot_available
      offer = Offer.new offer_params
      offer.distance = current_user.distance_to(Trade.find(offer_params[:trade_id]).user, :km).round(1)

      if offer.save
        render json: {status: 200}
      else
        render json: {errors: offer.errors}, status: 422
      end
    else
      render json: {errors: ["You must to have one slot available to make an offer"]}, status: 400
    end
  end

  def update
    offer = Offer.find offer_params[:id]
    offer.accept
    if offer.save
      render json: {status: 200}
    end
  end

  def destroy # cancel an offer from 'my trades'
    
  end

  def reject # 
    
  end
  
  def index # not needed?
    
  end

  def my
    offers = Offer.where("user_id = #{current_user}")
    render json: {
      offers: offers
    }, status: 200
  end

  private

  def offer_params
    params.require(:offer).permit!
  end
end
