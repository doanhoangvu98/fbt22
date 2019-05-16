class CommentsController < ApplicationController
  authorize_resource
  before_action :load_review, only: :create

  def create
    @comment = current_user.comments.build comment_params
    @comment.review_id = @review.id
    if @comment.save
      respond_to do |format|
        format.js
      end
    else
      flash[:danger] = t ".comment_error"
      redirect_to @review.tour
    end
  end

  private

  def comment_params
    params.require(:comment).permit :content, :reply_id
  end

  def load_review
    @review = Review.find_by id: params[:review_id]
    return if @review
    flash[:danger] = t "action.review_not_found"
    redirect_to :root
  end
end
