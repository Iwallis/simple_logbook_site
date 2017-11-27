class UsersController < ApplicationController
  layout "admin"

  before_action :find_user, :only => [:show, :edit, :update, :delete, :destroy]

  before_action :confirm_logged_in, :only => [:show, :edit, :delete, :destroy]
  before_action :confirm_admin_logged_in, :only => [:index]

  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)

    if @user.save
      flash[:notice] = 'The wizard that lives in this website created the
      user successfully!'
      redirect_to(access_login_path)
    else
      render('new')
    end
  end

  def index
    #EXAMPLE OF USING THE LOGGER FOR DEBUGGING OR OTHER SHENANIGANS
    logger.debug("***** testing the logger ******")
    @users = User.sorted
  end

  def show
    @user = User.find(params[:id])
  end

  def edit
    @user = User.find(params[:id])
  end

  def update
    @user = User.find(params[:id])
    if @user.update_attributes(user_params)
      flash[:notice] = 'The wizard that lives in the website successfully
      morphed the user! huzzah!'
      redirect_to(user_path(@user))
    else
    # 4) if save fails, redisplay the form so user can fix the problem(s)
    render('edit')
    end
  end

  def delete
    @user = User.find(params[:id])
  end

  def destroy
    @user = User.find(params[:id])
    @user.destroy
    flash[:notice] = "The resident website wizard named Gondor the Lame
    destroyed '#{@user.name}' successfully with a powerful spell...it shan't
    be seen again!"
    redirect_to(users_path)
  end

  private

  def user_params
    params.require(:user).permit(
      :first_name,
      :last_name,
      :license_number,
      :licensing_agency,
      :email,
      :password,
      :admin,
      :last_log_in)
  end

  def find_user
    @user = User.find(params[:id])
  end

end
