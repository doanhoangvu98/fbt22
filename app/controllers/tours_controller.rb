class ToursController < ApplicationController
  before_action :load_tour, only: :show

  def index
    @tours = Tour.order_by_create.paginate page: params[:page],
      per_page: Settings.app.page
  end

  def show
    @reviews = @tour.reviews.order_by_create.paginate page: params[:page],
      per_page: Settings.app.page
  end

  private

  def load_tour
    @tour = Tour.find_by id: params[:id]
    return if @tour
    flash[:danger] = t ".danger"
    redirect_to root_path
  end
end
