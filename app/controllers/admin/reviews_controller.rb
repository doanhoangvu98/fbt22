class Admin::ReviewsController < ApplicationController
  before_action :admin_user
  before_action :load_review, except: :index

  def index
    @reviews = Review.order_by_create.paginate page: params[:page],
      per_page: Settings.app.user.per_page
  end

  def destroy
    if @review.destroy
      flash[:success] = t ".review_deleted"
    else
      flash[:danger] = t ".review_delete_error"
    end
    redirect_to admin_reviews_path
  end

  private

  def load_review
    @review = Review.find_by id: params[:id]
    return if @review
    flash[:danger] = t "reviews.action.review_not_found"
    redirect_to :root
  end
end
