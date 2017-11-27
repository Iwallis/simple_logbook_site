class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception

  private

  def confirm_logged_in
    unless session[:user_id]
      flash[:notice] = "Please log in."
      redirect_to(access_login_path)
      # redirect_to is important (rather than render) because it prevents any other
      # actions from occuring
    end
  end
end
