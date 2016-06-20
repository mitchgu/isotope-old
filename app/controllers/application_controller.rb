class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception
  before_action :get_current_user

private

  def get_current_user
    return @current_user if @current_user
    if user_id = session[:user_id]
      # Check for active session first
      return @current_user = User.find_by_id(user_id)
    elsif has_login_token?
      user = User.from_login_token(login_token)
      if user == "WARN"
        log_out
        redirect_to login_path, alert: "Your ISOTOPE login cookies may have been compromised. Please log in again and exercise careful browsing habits." and return
      elsif !user
        log_out
      else
        log_in(user)
        register_login_token(user.refresh_login_token(login_token))
        return @current_user = user
      end
    end
  end

  def log_in(user)
    session[:user_id] = user.id
  end

  def logged_in?
    @current_user != nil
  end

  def ensure_logged_in
    unless @current_user
      redirect_to login_path(redirect_to: request.path),
        alert: "Please sign in first."
    end
  end
    end
  end

  def log_out
    if cookies[:login_token]
      @current_user.revoke_login_token(cookies[:login_token]) if @current_user
      cookies.delete(:login_token)
    end
    session[:user_id] = nil
  end

  def login_token
    cookies[:login_token]
  end

  def has_login_token?
    cookies[:login_token] != nil
  end

  def register_login_token(token)
    cookies.permanent[:login_token] = token.serialize
  end

  helper_method :current_user

end
