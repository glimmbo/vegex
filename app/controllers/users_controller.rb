class UsersController < ApplicationController
  # before_action :authenticate_user! except: [:create, :current]

  def index
    users = User.nearbys(current_user.range) #geocoder method
  end

  def show
    user = current_user
    render json: {
      user: user
    }, status: 200
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
    user = User.find(current_user)
    user.remove
    render json: {

    }, status: 200
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
