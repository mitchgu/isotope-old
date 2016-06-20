class SessionsController < ApplicationController

  def new
  end

  def create
    if @current_user
      # If they're logged in already don't do it again
      return redirect_to params[:redirect_to] ||= dashboard_path
    end
    user = params[:email_or_username].include?("@") ?
      User.find_by_email(params[:email_or_username]) :
      User.find_by_username(params[:email_or_username])
    # If the user exists AND the password entered is correct.
    if user && user.authenticate(params[:password])
      log_in(user)
      if params[:remember]
        register_login_token(user.new_login_token)
      end
      redirect_to params[:redirect_to] ||= dashboard_path
    else
      # If user's login doesn't work, send them back to the login form.
      flash[:error] = "Invalid credentials"
      if params[:redirect_to]
        redirect_to login_path(redirect_to: params[:redirect_to])
      else
        redirect_to login_path
      end
    end
  end

  def destroy
    if logged_in?
      log_out
      flash[:notice] = "You have successfully logged out"
    end
    redirect_to home_path
  end

end
