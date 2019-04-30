class UsersController < ApplicationController
  before_action :load_user, except: %i(create new)
  before_action :logged_in_user, except: %i(show new create)
  before_action :correct_user, only: %i(edit update)

  def new
    @user = User.new
  end

  def show; end

  def create
    @user = User.new user_params
    if @user.save
      log_in @user
      flash[:success] = t ".signup_success"
      redirect_to tours_path
    else
      render :new
    end
  end

  def edit; end

  def update
    if @user.update_attributes user_params
      flash[:success] = t ".profile_updated"
      redirect_to tours_path
    else
      render :edit
    end
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

  # Confirms the correct user.
  def correct_user
    redirect_to root_path unless current_user? @user
  end
end
