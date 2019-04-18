module Admin::AdministratorsHelper
  # Confirms an admin user.
  def admin_user
    redirect_to root_path unless logged_in? && current_user.admin?
  end

  def is_status_close? tour
    if tour.close?
      link_to t(".close"), change_status_admin_tour_path(tour),
        class: "btn btn-danger", method: :patch, remote: true
    else
      link_to t(".open"), change_status_admin_tour_path(tour),
        class: "btn btn-success", method: :patch, remote: true
    end
  end
end
