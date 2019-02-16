class OffersController < ApplicationController

  def create # make an offer
    
  end

  def destroy # cancel an offer
    
  end

  def reject
    
  end
  
  def index # not needed?
    
  end

  def my
    offers = Offer.where("user_id = #{current_user}")
    render json: {
      offers: offers
    }, status: 200
  end

end
