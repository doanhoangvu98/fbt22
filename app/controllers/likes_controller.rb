class LikesController < ApplicationController
  before_action :load_review
  before_action :load_like, only: :destroy

  before_action :load_like, :already_liked?, only: :destroy

  def create
    @like = Like.create(user_id: current_user.id, review_id: @review.id)
    if @like.save
      flash[:success] = t "controllers.likes.create.success"
    else
      flash[:danger] = t "controllers.likes.create.danger"
    end
    redirect_to tour_path @review.tour
  end

  def destroy
    if @like.destroy
      flash[:success] = t "controllers.likes.destroy.success"
    else
      flash[:danger] = t "controllers.likes.destroy.danger"
    end
    redirect_to tour_path @review.tour
  end

  private

  def load_review
    @review = Review.find_by id: params[:review_id]
    return if @review
    flash[:danger] = t "controllers.likes.load.danger"
  end

  def load_like
    @like = @review.likes.find_by id: params[:id]
    return if @like
    flash[:danger] = t "controllers.likes.load.danger"
  end

  def already_liked?
    current_user.likes.find_by(review_id: params[:review_id])
  end
end
