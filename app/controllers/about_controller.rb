class AboutController < ApplicationController

  def show
    render template: "about/#{params[:page]}"
  end

end
