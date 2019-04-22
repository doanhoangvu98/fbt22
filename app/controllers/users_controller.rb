class UsersController < ApplicationController
  before_action :load_user, except: %i(create new index)
  before_action :logged_in_user, except: %i(show new create)
  before_action :correct_user, only: %i(edit update)
  before_action :admin_user, only: :destroy

  def index
    @users = User.sort_by_created_at_desc.paginate page: params[:page],
      per_page: Settings.app.user.per_page
  end

  def new
    @user = User.new
  end

  def show; end

  def create
    @user = User.new user_params
    if @user.save
      log_in @user
      flash[:success] = t ".signup_success"
      redirect_to @user
    else
      render :new
    end
  end

  def edit; end

  def update
    if @user.update_attributes user_params
      flash[:success] = t ".profile_updated"
      redirect_to @user
    else
      render :edit
    end
  end

  def destroy
    if @user.destroy
      flash[:success] = t ".user_deleted"
    else
      flash[:danger] = t ".user_delete_error"
    end
    redirect_to users_path
  end

  private

  def user_params
    params.require(:user).permit :firstname, :lastname, :address,
      :phone, :email, :password, :password_confirmation, :picture
  end

  def load_user
    @user = User.find_by id: params[:id]
    return if @user
    flash[:danger] = t "users.action.user_not_found"
    redirect_to :root
  end

  # Confirms a logged-in user.
  def logged_in_user
    return if logged_in?
    store_location
    flash[:danger] = t "users.action.please_login"
    redirect_to login_path
  end

  # Confirms the correct user.
  def correct_user
    redirect_to root_path unless current_user? @user
  end
end
