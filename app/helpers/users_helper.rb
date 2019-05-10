module UsersHelper
  def full_name
    "#{firstname} #{lastname}"
  end

  # Confirms a logged-in user.
  def logged_in_user
    return if user_signed_in?
    store_location_for(:user, request.fullpath)
    flash[:danger] = t "users.action.please_login"
    redirect_to sign_in_path
  end

  def load_comment_review review
    review.comments.load_comment
  end

  def load_reply_comment reply_id
    Comment.load_reply_comment reply_id
  end
end
