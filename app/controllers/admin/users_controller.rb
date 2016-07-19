class Admin::UsersController < ApplicationController

  before_filter :admin_access

  def index
    @users = User.all
  end

  def edit
    @user = User.find(params[:id])
  end

  def update
    @user = User.find(params[:id])
    if @user.update(user_params)
      redirect_to admin_users_url, notice: "User successfully updated"
    else
      render 'edit'
    end
  end


  protected
  def user_params
    params.require(:user).permit(:firstname, :lastname, :email, :password, :password_confirmation)
  end
end
