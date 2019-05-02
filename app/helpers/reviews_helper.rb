module ReviewsHelper
  def check_liked review
    # review.likes.liked(current_user.id, review.id)
    review.likes.find{|like| like.user_id == current_user.id}
  end
end
