class LogbookController < ApplicationController
  layout 'admin'

  before_action do confirm_correct_user(@user = User.find(params[:id]))

  # these 8 items make up the core of CRUD (create read update delete)

  # these two are part of create
  def new
    @logbook = Logbook.new
  end

  def create
    # steps to save
    # 1) Instantiate a new object using input from the form
    @logbook = Logbook.new(logbook_params)
    # 2) Save the new object
    if @logbook.save
      # 3) if save succeeds, redirect user to desired page
      flash[:notice] = 'Logbook created successfully'
      redirect_to(logbook_path(@logbook))
    else
      # 4) if save fails, redisplay the form so user can fix the problem(s)
      @users = User.sorted
      render('new')
    end
  end

  def show
    @user = User.find(session[:user_id])    
  end

  # these are part of update
  # edit displays the form and update submits it to the db
  def edit
    @logbook = Logbook.find(params[:id])
  end

  def update
    # steps to update
    # 1) find a new object using input from the form
    @logbook = Logbook.find(params[:id])
    # 2) update the object
    if @logbook.update_attributes(logbook_params)
    # 3) if save succeeds, redirect user to desired page
      flash[:notice] = 'Logbook updated successfully'
      redirect_to(logbook_path(@logbook))
    else
      # 4) if save fails, redisplay the form so user can fix the problem(s)
      render('edit')
    end
  end

  # these are part of delete
  def delete
    @logbook = Logbook.find(params[:id])
  end

  def destroy
    @logbook = Logbook.find(params[:id])
    @logbook.destroy
    flash[:notice] = "Logbook for '#{@logbook.user.name}'
      deleted successfully"
    redirect_to(user_path(@logbook.user))
  end
end

  private

  def logbook_params
    params.require(:logbook).permit()
  end

end
