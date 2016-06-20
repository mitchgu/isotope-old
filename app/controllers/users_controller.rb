class UsersController < ApplicationController

  before_action :ensure_logged_in, only: :show

  def new
    # Register form view
  end

  def show
    # Dashboard view
  end

  def create
    user = User.new(user_params)
    if user.valid?
      user.save
      session[:user_id] = user.id
      redirect_to profile_path
      return
    else
      flash[:error] = user.errors.full_messages.map{|e| "<li>#{e}</li>"}.join("\n")
      redirect_to register_path
      return
    end
  end

  def activate
    if params[:token]
      at = ActivationToken.from_token(params[:token]) or not_found
      at.user.update(activated: true)
      at.destroy
      log_in at.user
      redirect_to home_path, notice: "Account activated!"
    else
      not_found
    end
  end

  def resend_activation
    @current_user.send_activation_email
    redirect_to profile_path, notice: "Activation email resent"
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
