class Admin::UsersController < ApplicationController
  before_action :admin_user
  before_action :load_user, except: :index

  def index
    @search = User.ransack params[:q]
    @users = @search.result.sort_by_created_at_desc.paginate page: params[:page],
      per_page: Settings.app.user.per_page
  end

  def destroy
    if @user.destroy
      flash[:success] = t ".user_deleted"
    else
      flash[:danger] = t ".user_delete_error"
    end
    redirect_to admin_users_path
  end

  private

  def load_user
    @user = User.find_by id: params[:id]
    return if @user
    flash[:danger] = t "users.action.user_not_found"
    redirect_to :root
  end
end
