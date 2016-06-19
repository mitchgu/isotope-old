class UsersController < ApplicationController

  before_action :authorize, except: [:new, :create]

  def new
  end

  def show
  end

  def create
    user = User.new(user_params)
    if user.valid?
      user.save
      session[:user_id] = user.id
      UserMailer.delay.activation_email(user)
      redirect_to dashboard_path
      return
    else
      flash[:error] = user.errors.full_messages.map{|e| "<li>#{e}</li>"}.join("\n")
      redirect_to register_path
      return
    end
  end

private

  def user_params
    if params.key?(:user)
      return params.require(:user).permit(:username, :email, :first_name, :last_name, :password, :password_confirmation)
    else
      return {}
    end
  end
end
