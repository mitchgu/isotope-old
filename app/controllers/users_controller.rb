class UsersController < ApplicationController

  before_action :authorize, unless: [:new, :create]

  def new
  end

  def show
  end

  def create
    user = User.new(user_params)
    if user.valid?
      user.save
      session[:user_id] = user.id
      redirect_to '/'
      return
    else
      redirect_to "/register"
    end
  end

private

  def user_params
    params.require(:user).permit(:username, :email, :first_name, :last_name, :password, :password_confirmation)
  end
end
