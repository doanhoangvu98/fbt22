class BookingsController < ApplicationController
  before_action :logged_in_user
  before_action :load_tour, only: :create
  before_action :load_booking, only: :change_status

  def create
    @booking = current_user.bookings.new booking_params
    @booking.tour_id = @tour.id
    @booking.price = @booking.quantity * @tour.price
    save_success?
  end

  def index
    @bookings = current_user.bookings.order_by_create.paginate page:
      params[:page], per_page: Settings.app.user.per_page
  end

  def change_status
    if @booking.cancel? && @booking.tour.tour_start < Time.now
      @booking.waiting!
      flash[:danger] = "waiting"
      redirect_to bookings_path
    elsif @booking.waiting?
      @booking.cancel!
      flash[:danger] = "cancel"
      redirect_to bookings_path
    else
      flash[:danger] = "Expire day"
      redirect_to bookings_path
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

  def save_success?
    if @booking.save
      flash[:success] = t ".booking_success"
      redirect_to bookings_path
    else
      flash[:danger] = t ".booking_fail"
      @reviews = @tour.reviews.order_by_create.paginate page: params[:page],
        per_page: Settings.app.page
      render "tours/show"
    end
  end
end
