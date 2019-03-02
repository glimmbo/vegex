class UsersController < ApplicationController
  # before_action :authenticate_user! except: [:create, :current]

  def index #later, not needed
    # if current_user.range
    #   users = current_user.nearbys(current_user.range)
    #   render json: {
    #     users: users
    #   }, status: 200
    # else
    #   users = User.all
    #   render json: {
    #     users: users
    #   }
    # end
  end

  def show # √
    user = ActiveModelSerializers::SerializableResource.new(current_user)
    render json: {
      user: user
    }, status: 200
  end

  def create # √ X
    user = User.new user_params
    set_ip_address(user)
    user.slots = 1
    user.completion = 0.0
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

  def destroy # √
    user = User.find(current_user.id)
    user.remove
    if user.save
      render json: {status: 200}
    else
      render json: {status: 400}
    end
  end

  def current # √
    render json: {
      current_user: ActiveModelSerializers::SerializableResource.new(current_user).as_json
    }, status: 200
  end

  private
  def user_params
    params.require(:user).permit(:name, :email, :password, :password_confirmation, :range, :about, :address, :latitude, :longitude)
  end

  def set_ip_address(user)
    if user.address.length == 0 || user.address == nil
      user.address = "50.64.108.159"
      # user.address = request.remote_ip (once hosted)
    end
  end

end
