class UsersController < ApplicationController
  before_action :authenticate_user!

  def index
    # stretch: an index of users located within radius preferrence?
  end

  def show
    # user's profile page or
    # current trade partner (:offer_user_id)
  end

  def new
    @user = User.new
  end

  def create
    @user = User.new user_params
    if @user.save
      session[:user_id] = @user.id
      render json: {
        #new user info, sign up confirm
      }, status: 200
      # flash[:primary] = "Signed up" need to send message in json, render in component
      # redirect_to root_path ## 'redirects' done in react. redirect to profile page to set preferrences
    else
      render :new
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
    params.require(:user).permit(
      :first_name, :last_name, :email, :password, :password_confirmation
    )
  end
end
