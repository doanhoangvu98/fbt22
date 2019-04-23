class Admin::TravellingsController < ApplicationController
  before_action :admin_user
  before_action :load_locations, except: :destroy
  before_action :load_travelling, except: %i(create index)
  before_action :build_travelling, only: :index

  def create
    @travelling = Travelling.new travelling_params
    if @travelling.save
      flash[:success] = t ".add_travelling_success"
    else
      flash[:danger] = t ".add_travelling_error"
    end
    redirect_to admin_travellings_path
  end

  def index
    @travellings = Travelling.sort_by_created_desc.paginate page: params[:page],
      per_page: Settings.app.user.per_page
  end

  def edit; end

  def update
    if @travelling.update_attributes travelling_params
      flash[:success] = t ".update_travelling_success"
      redirect_to admin_travellings_path
    else
      flash[:danger] = t ".update_travelling_error"
      render :edit
    end
  end

  def destroy
    if @travelling.destroy
      flash[:success] = t ".delete_travelling_success"
    else
      flash[:danger] = t ".delete_travelling_error"
    end
    redirect_to admin_travellings_path
  end

  private

  def travelling_params
    params.require(:travelling).permit :location_start_id,
      :location_end_id
  end

  def load_locations
    @locations = Location.all.map{|l| [l.name, l.id]}
  end

  def load_travelling
    @travelling = Travelling.find_by id: params[:id]
    return if @travelling
    flash[:danger] = t "travelling.action.travelling_not_found"
    redirect_to :root
  end

  def build_travelling
    @travelling = Travelling.new
  end
end
