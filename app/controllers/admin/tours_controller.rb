class Admin::ToursController < ApplicationController
  before_action :admin_user
  before_action :load_tour, except: %i(create new index)
  before_action :load_categories, except: %i(index destroy status)
  before_action :load_travellings, except: %i(index destroy status)

  def new
    @tour = Tour.new
  end

  def create
    @tour = Tour.new tour_params
    if @tour.save
      flash[:success] = t ".add_tour_success"
      redirect_to admin_tours_path
    else
      render :new
    end
  end

  def index
    @tours = Tour.search(params[:term]).order_by_create.paginate page:
      params[:page], per_page: Settings.app.user.per_page
  end

  def edit; end

  def update
    if @tour.update_attributes tour_params
      flash[:success] = t ".tour_updated"
      redirect_to admin_tours_path
    else
      render :edit
    end
  end

  def destroy
    if @tour.destroy
      flash[:success] = t ".tour_deleted"
    else
      flash[:danger] = t ".tour_delete_error"
    end
    redirect_to admin_tours_path
  end

  def change_status
    @tour.close? ? @tour.open! : @tour.close!
    respond_to do |format|
      format.js
    end
  end

  private

  def tour_params
    params.require(:tour).permit :title, :description, :image, :price,
      :num_people, :tour_start, :tour_finish, :category_id, :travelling_id
  end

  def load_tour
    @tour = Tour.find_by id: params[:id]
    return if @tour
    flash[:danger] = t "tours.action.tour_not_found"
    redirect_to :root
  end

  def load_categories
    @categories = Category.sort_by_name_at_asc.map{|c| [c.name, c.id]}
  end

  def load_travellings
    @travellings = Travelling.sort_by_name_location_asc.map do |t|
      ["#{t.location_start.name} - #{t.location_end.name}", t.id]
    end
  end
end
