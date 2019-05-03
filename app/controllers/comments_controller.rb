class CommentsController < ApplicationController
  before_action :set_comment, only: [:destroy]

  def create
    @comment = Comment.create! comment_params
    respond_to do |format|
      format.html{redirect_to :back}
      format.js
    end
  end

  def destroy
    if @comment.destroy
      flash[:success] = t "controllers.comments.destroy.success"
    else
      flash[:danger] = t "controllers.comments.destroy.danger"
    end
    redirect_to :back
  end

  private

  def comment_params
    params.require(:comment).permit :post_id, :user_id, :content
  end

  def set_comment
    @comment = Comment.find_by id: params[:id]
    return if @comment
    flash[:danger] = t "controllers.comments.set.not_found"
    redirect_to :root
  end
end
