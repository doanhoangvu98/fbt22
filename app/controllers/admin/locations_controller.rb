class Admin::LocationsController < ApplicationController
  before_action :admin_user
  before_action :load_location, except: %i(create index)

  def create
    @location = Location.new location_params
    if @location.save
      flash[:success] = t ".add_location_success"
    else
      flash[:danger] = t ".add_location_error"
    end
    redirect_to admin_locations_path
  end

  def index
    @location = Location.new
    @locations = Location.sort_by_name.paginate page: params[:page],
      per_page: Settings.app.user.per_page
  end

  def edit; end

  def update
    if @location.update_attributes location_params
      flash[:success] = t ".update_location_success"
    else
      flash[:danger] = t ".update_location_error"
    end
    redirect_to admin_locations_path
  end

  def destroy
    if @location.destroy
      flash[:success] = t ".delete_location_success"
    else
      flash[:danger] = t ".delete_location_error"
    end
    redirect_to admin_locations_path
  end

  private

  def location_params
    params.require(:location).permit :name
  end

  def load_location
    @location = Location.find_by id: params[:id]
    return if @location
    flash[:danger] = t "location.action.location_not_found"
    redirect_to :root
  end
end
