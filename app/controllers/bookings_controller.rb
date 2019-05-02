class BookingsController < ApplicationController
  before_action :load_tour, except: %i(index change_status)
  before_action :load_booking, only: %i(change_status)
  before_action :not_logged_in, except: :new

  def new
    @booking = Booking.new
  end

  def create
    @booking = current_user.bookings.new booking_params
    @booking.tour_id = @tour.id
    @booking.price = @booking.quantity * @tour.price
    if @booking.save
      flash[:success] = t ".booking_success"
      redirect_to bookings_path
    else
      flash[:danger] = t ".booking_fail"
      render :new
    end
  end

  def index
    @bookings = current_user.bookings.order_by_create
      .paginate page: params[:page], per_page: Settings.app.user.per_page
  end

  def change_status
    if @booking.cancel?
      @booking.waiting!
    elsif @booking.waiting?
      @booking.cancel!
    end
    respond_to do |format|
      format.js
    end
  end

  private

  def booking_params
    params.require(:booking).permit :quantity, :name, :phone
  end

  def load_tour
    @tour = Tour.find_by id: params[:tour_id]
    return if @tour
    flash[:danger] = t "tours.action.tour_not_found"
    redirect_to :root
  end

  def load_booking
    @booking = current_user.bookings.find_by id: params[:id]
    return if @booking
    flash[:danger] = t "bookings.action.booking_not_found"
    redirect_to :root
  end

  def not_logged_in
    return if logged_in?
    flash[:danger] = t "users.user_not_logged_in"
    redirect_to :root
  end
end
