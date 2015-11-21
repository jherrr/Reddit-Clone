class UsersController < ApplicationController

  def new
    @user = User.new
    render :new
  end

  def create
    @user = User.new(user_params)

    if @user.save
      log_in(@user)
      redirect_to user_url
    else
      render :new
    end
  end

  def show
    @user = current_user
    render :show
  end

  def edit
    @user = current_user
    render :edit
  end

  def update
    @user = User.new(user_params)
    if @user.save
      redirect_to user_url
    else
      render :edit
    end
  end

  private

  def user_params
    params.require(:user).permit(:email, :password)
  end
end
