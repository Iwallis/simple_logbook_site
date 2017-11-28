class FlightController < ApplicationController
  layout 'admin'

  before_action do confirm_correct_user(@user = User.find(params[:id]))

  def new
    @flight = Flight.new
  end

  def create
    @flight = Flight.new

    if @flight.save
      flash[:notice] = 'The wizard that lives in this website created the
      flight successfully!'
      redirect_to(flights_path) # flights_path will return to index of flights
    else
      render('new') # reload the new flight page, doing it with render instead
                    # of a redirect_to allows the @flight object to persist so
                    # the fields remain filled in.  TODO: add a flash message
                    # that tells the user what the issue was.
    end
  end

  def index
    @flights = Flight.sorted
  end

  def show
    @flight = Flight.find(params[:id])
  end

  def edit
    @flight = Flight.find(params[:id])
    @flight_count = Flight.count    
  end

  def update
    @flight = Flight.find(params[:id])

    if @flight.update_attributes(flight_params)
      flash[:notice] = 'The wizard that lives in the website successfully
      morphed the flight! huzzah!'
      redirect_to(flight_path(@flight))
    else
    # 4) if save fails, redisplay the form so user can fix the problem(s)
    render('edit')
    end
  end

  def delete
    @flight = Flight.find(params[:id])
  end

  def destroy
    @flight = Flight.find(params[:id])
    @flight.destroy
    flash[:notice] = "The resident website wizard named Gondor the Lame
    destroyed '#{@flight.name}' successfully with a powerful spell...it shan't
    be seen again!"
    redirect_to(flights_path)
  end

  private

  def flight_params
    params.require(:flight).permit(:date, :type, :ident, :pic,
      :sic, :single_engine?, :cross_country?, :dual_flight?, :day_hours,
      :night_hours, :sim_hours, :imc_hours, :hood_hours, :ifr_approaches,
      :route, :comments)
  end
end
