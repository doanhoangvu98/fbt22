module ReviewsHelper
  def check_liked review
    review.likes.liked(current_user.id, review.id)
  end
end
