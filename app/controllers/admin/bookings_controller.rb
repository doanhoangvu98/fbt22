class Admin::BookingsController < ApplicationController
  before_action :admin_user
  before_action :load_booking, only: :change_status

  def index
    @bookings = Booking.order_by_create.status_not_cancel.paginate page:
      params[:page], per_page: Settings.app.user.per_page
    calculate_revenue
  end

  def change_status
    if Booking.statuses.key(3) == params[:status]
      @booking.accept!
    elsif Booking.statuses.key(2) == params[:status]
      @booking.reject!
    end
    calculate_revenue
    respond_to do |format|
      format.js
    end
  end

  private

  def load_booking
    @booking = Booking.find_by id: params[:id]
    return if @booking
    flash[:danger] = t "action.booking_not_found"
    redirect_to :root
  end

  def calculate_revenue
    @total_revenue = Booking.accept.sum(:price)
    @total_revenue_moth = Booking.accept.from_month.sum(:price)
  end
end
