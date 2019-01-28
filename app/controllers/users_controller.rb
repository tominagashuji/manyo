class UsersController < ApplicationController
  skip_before_action :login_required

  def new
    if session[:user_id]
      redirect_to user_path(current_user.id),notice: 'ログアウトして新規登録しませう'
    else
      @user = User.new
    end
  end

  def create
    @user = User.new(user_params)
    if @user.save
      session[:user_id] = @user.id
      redirect_to user_path(@user.id),notice: 'ログインしました。'
    else
      render 'new'
    end
  end

  def show
    @user = User.find(params[:id])
    if current_user.id != @user.id
      redirect_to user_path(current_user.id),nottice: '他のユーザーです'
    end
  end

  private

  def user_params
    params.require(:user).permit(:name,:email,:password,
    :password_confirmation)
  end
end
