class ReviewsController < ApplicationController
  before_action :load_review, only: %i(edit update destroy)

  def new
    @review = Review.new
  end

  def edit; end

  def create
    @review = Review.new review_params
    if @review.save
      flash[:success] = t "controllers.reviews.create.success"
    else
      flash[:danger] = t "controllers.reviews.create.danger"
    end
    redirect_to @review.tour
  end

  def update
    if @review.update_attributes review_params
      flash[:success] = t "controllers.reviews.destroy.success"
    else
      flash[:danger] = t "controllers.reviews.destroy.danger"
    end
    redirect_to @review.tour
  end

  def destroy
    if @review.destroy
      flash[:success] = t "controllers.reviews.destroy.success"
    else
      flash[:danger] = t "controllers.reviews.destroy.danger"
    end
    redirect_to @review.tour
  end

  private

  def load_review
    @review = Review.find_by id: params[:id]
    return if @review
    flash[:danger] = t "controllers.reviews.load.danger"
  end

  def review_params
    params.require(:review).permit(:type_review, :rating, :content,
      :tour_id).merge!(user_id: current_user.id)
  end
end
