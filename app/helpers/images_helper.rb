module ImagesHelper
  # Check avatar is empty or not
  def check_none_image user
    user.picture? ? user.picture.url : Settings.app.user.none_avatar
  end
end
