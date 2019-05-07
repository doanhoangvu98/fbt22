class ToursController < ApplicationController
  before_action :load_tour, :load_review, only: :show

  def index
    @search_term = params[:search] if params[:search]
    @tours = Tour.order_by_create.search_by(@search_term).paginate page:
      params[:page], per_page: Settings.app.page
  end

  def show
    @booking = Booking.new
  end

  private

  def load_tour
    @tour = Tour.find_by id: params[:id]
    return if @tour
    flash[:danger] = t ".danger"
    redirect_to root_path
  end

  def load_review
    @reviews = @tour.reviews.order_by_create.paginate page: params[:page],
      per_page: Settings.app.page
    return if @review
  end
end
