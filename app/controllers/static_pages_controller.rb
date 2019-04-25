class StaticPagesController < ApplicationController
  def home
    @tours = Tour.all.order_by_create.paginate page: params[:page],
      per_page: Settings.app.page
  end

  def about; end

  def contact; end
end
