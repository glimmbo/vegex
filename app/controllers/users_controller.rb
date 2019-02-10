class UsersController < ApplicationController
  # before_action :authenticate_user! except: [:create, :current]

  def index
    # stretch: an index of users located within radius preferrence?
  end

  def show
    # user's profile page or
    # current trade partner (:offer_user_id)
  end

  def create
    user = User.new user_params
    user.trade_slots = 0
    user.trade_completion = 0.0
    user.status = "active"
    # user.location = # get from an api
    if user.save
      session[:user_id] = user.id
      render json: {
        id: user.id
      }, status: 200
    else
      render json: {
        status: 422
      }, status: 422
    end
  end

  def destroy
    # soft delete, add migration for user :status
  end

  def current
    render json: {
      status: 200,
      current_user: ActiveModelSerializers::SerializableResource.new(current_user).as_json
    }
  end

  private
  def user_params
    {email: params[:email],
    name: params[:name],
    password: params[:password],
    password_confirmation: params[:password_confirmation]}
  end
end
