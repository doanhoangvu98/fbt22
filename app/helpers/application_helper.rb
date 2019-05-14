module ApplicationHelper
  def current_user? current_user
    self.current_user == current_user
  end
end
