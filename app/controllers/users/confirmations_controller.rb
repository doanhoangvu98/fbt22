class Users::ConfirmationsController < Devise::ConfirmationsController
  protected

  def after_confirmation_path_for resource
    sign_in resource
    user_path resource
  end
end
