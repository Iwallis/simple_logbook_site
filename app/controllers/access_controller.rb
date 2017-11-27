class AccessController < ApplicationController
  layout 'admin'

  before_action :confirm_logged_in, :except => [:login, :attempt_login, :logout]

  def menu
    # going to the database is expensive for page performance, so it's not
    # worth asking the database for just the username...
    @username = session[:username]
    @admin = session[:admin]
  end

  def login
    #login form doesnt need anything here
  end

  def attempt_login
    if params[:email].present? && params[:password].present?
      found_user = User.where(:email => params[:email]).first
      if found_user
        authorized_user = found_user.authenticate(params[:password])
      end
    end

    if authorized_user
      session[:user_id] = authorized_user.id
      session[:username] = authorized_user.first_name + " " + authorized_user.last_name
      session[:admin] = authorized_user.admin
      flash[:notice] = "You are now logged in"
      redirect_to(admin_path)
    else
      flash.now[:notice] = "Invalid email/password combination"
      render('login')
    end
  end

  def logout
    session[:user_id] = nil
    session[:username] = nil
    flash[:notice] = 'logged out'
    redirect_to(access_login_path)
  end

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
