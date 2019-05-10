class StaticPagesController < ApplicationController
  def home
    @tours = Tour.order_by_create.open_tour.paginate page: params[:page],
      per_page: Settings.app.page
  end

  def about; end

  def contact; end
end
