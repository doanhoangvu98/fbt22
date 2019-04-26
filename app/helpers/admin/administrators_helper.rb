module Admin::AdministratorsHelper
  # Confirms an admin user.
  def admin_user
    redirect_to root_path unless logged_in? && current_user.admin?
  end
end
