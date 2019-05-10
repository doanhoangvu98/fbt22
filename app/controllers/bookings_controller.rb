class BookingsController < ApplicationController
  before_action :authenticate_user!, only: %i(new create)
  before_action :load_tour, only: %i(new create)
  before_action :load_booking, only: :change_status
  authorize_resource

  def new
    @booking = Booking.new
  end

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
    respond_to do |format|
      if @booking.cancel? && @booking.tour.tour_start < Time.now
        @booking.waiting!
        flash[:notice] = t ".waiting"
      elsif @booking.waiting?
        @booking.cancel!
        flash[:success] = t ".cancel"
      else
        flash[:danger] = t".expire"
      end
      redirect_to bookings_path
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
