class UsersController < ApplicationController
  before_action :load_user, only: :show

  def new
    @user = User.new
  end

  def show; end

  def create
    @user = User.new user_params
    if @user.save
      flash[:success] = t ".signup_success"
      redirect_to @user
    else
      render :new
    end
  end

  private

  def user_params
    params.require(:user).permit :firstname, :lastname, :address,
      :phone, :email, :password, :password_confirmation
  end

  def load_user
    @user = User.find_by id: params[:id]
    return if @user
    flash[:danger] = t "users.action.user_not_found"
    redirect_to :root
  end
end
