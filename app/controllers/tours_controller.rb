class ToursController < ApplicationController
  def index
    @tours = Tour.all.order_by_create.paginate page: params[:page],
      per_page: Settings.app.page
  end

  def show; end
end
