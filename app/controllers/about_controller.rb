class AboutController < ApplicationController

  def show
    if request.path == "/" && @current_user
      redirect_to profile_path
    else
      render template: "about/#{params[:page]}"
    end
  end

end
