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
      redirect_to action: "show"
      return
    else
      flash[:error] = user.errors.full_messages.map{|e| "<li>#{e}</li>"}.join("\n")
      redirect_to action: "new"
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
