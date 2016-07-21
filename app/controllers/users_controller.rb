class UsersController < ApplicationController
  def new
    @user = User.new
  end

  def edit
    @user = User.find(params[:id])
  end

  def create
    @user = User.new(user_params)

    if @user.save
      session[:user_id] = @user.id
      redirect_to admin_users_path, notice: "#{@user.email} was added successfully"
    else
      render :new
    end
  end

  def show
    @user = User.find(params[:id])
  end

  protected
  def user_params
    params.require(:user).permit(:firstname, :lastname, :email, :password, :password_confirmation)
  end
end
