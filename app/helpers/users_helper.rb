module UsersHelper
  def full_name
    "#{firstname} #{lastname}"
  end

  # Confirms a logged-in user.
  def logged_in_user
    return if logged_in?
    store_location
    flash[:danger] = t "users.action.please_login"
    redirect_to login_path
  end

  def load_comment_review review
    review.comments.load_comment
  end

  def load_reply_comment reply_id
    Comment.load_reply_comment reply_id
  end

  def check_liked review
    review.likes.liked(current_user.id, review.id)
  end
end
