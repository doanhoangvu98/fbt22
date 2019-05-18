class Admin::CategoriesController < ApplicationController
  before_action :admin_user
  before_action :load_category, except: %i(create index)

  def index
    @category = Category.new
    @categories = Category.paginate page: params[:page],
      per_page: Settings.app.user.per_page
  end

  def create
    @category = Category.new category_params
    if @category.save
      flash[:success] = t ".success"
    else
      flash[:danger] = t ".danger"
    end
    redirect_to admin_categories_path
  end

  def edit; end

  def update
    if @category.update_attributes category_params
      flash[:success] = t ".success"
    else
      flash[:danger] = t ".danger"
    end
    redirect_to admin_categories_path
  end

  def destroy
    if @category.destroy
      flash[:success] = t ".success"
    else
      flash[:danger] = t ".danger"
    end
    redirect_to admin_categories_path
  end

  private

  def category_params
    params.require(:category).permit :name
  end

  def load_category
    @category = Category.find_by id: params[:id]
    return if @category
    flash[:danger] = t "categories.action.category_not_found"
    redirect_to :root
  end
end
