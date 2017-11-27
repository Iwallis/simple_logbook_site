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

  def confirm_admin_logged_in
    confirm_logged_in
    unless session[:admin]
      flash[:notice] = "Access Denied"
      redirect_to(user_path(session[:user_id]))
    end
  end
end
