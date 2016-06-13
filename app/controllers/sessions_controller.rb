class SessionsController < ApplicationController

  def new
  end

  def create
    if params[:email_or_username].include? "@"
      user = User.find_by_email(params[:email_or_username])
    else
      user = User.find_by_username(params[:email_or_username])
    end
    # If the user exists AND the password entered is correct.
    if user && user.authenticate(params[:password])
      # Save the user id inside the browser cookie. This is how we keep the user
      # logged in when they navigate around our website.
      session[:user_id] = user.id
      redirect_to params[:redirect_to] ||= "/profile"
    else
      # If user's login doesn't work, send them back to the login form.
      flash[:notice] = "Invalid credentials"
      if params[:redirect_to]
        redirect_to "/login?redirect_to=#{params[:redirect_to]}"
      else
        redirect_to "/login"
      end
    end
  end

  def destroy
    session[:user_id] = nil
    redirect_to '/'
  end

end
