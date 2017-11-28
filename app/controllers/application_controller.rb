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
    # use this for admin only content
    confirm_logged_in
    unless session[:admin]
      # flash[:notice] = "Access Denied"
      logger.debug("***** NOT AN ADMIN ******")
      redirect_to("/denied")
    end
  end

  def confirm_correct_user(user)
    # use this for user only content
    user_id = user.id
    # make sure that user is logged in
    confirm_logged_in
    # then check for priveleges
    # unless user is the correct user or an admin, don't load the page and go
    # to an error page instead
    unless session[:user_id] == user.id || session[:admin]
      logger.debug("***** NOT CORRECT USER ******")
      logger.debug("***** User is: #{user_id} ******")
      logger.debug("***** Trying to access #{session[:user_id]} ******")
      # flash[:notice] = "Access Denied, incorrect user"
      redirect_to("/denied")
    end
  end

end
