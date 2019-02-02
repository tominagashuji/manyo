class Admin::UsersController < ApplicationController
  before_action :require_admin

  def index
    @users =User.select(:id, :name, :email, :created_at, :updated_at, :admin).includes(:tasks)
  end

  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)

    if @user.save
      redirect_to admin_users_path(@user.id), notice: "ユーザー「#{@user.name}」を登録しました"
    else
      render :new
    end
  end

  def edit
    @user = User.find(params[:id])
  end

  def show
    @user = User.find(params[:id])
    @tasks = @user.tasks
  end

  def update
    @user = User.find(params[:id])
    if @user.admin? && User.where(admin: true).count == 1
      redirect_to admin_users_path, notice: "最後の管理ユーザーです！変更不可"
    else
      if @user.update(user_params)
        redirect_to admin_users_path,notice: "ユーザーを更新しました！"
      else
        render :new
      end
    end
  end

  def destroy
    @user = User.find(params[:id])
    if @user.admin? && User.where(admin: true).count == 1
      redirect_to admin_users_path, notice: "最後の管理ユーザーです！削除不可"
    else
      @user.destroy
      redirect_to admin_users_path, notice: "ユーザー「#{@user.name}」を削除しました！"
    end

  end

  private
  def user_params
    params.require(:user).permit(:name, :email, :admin, :password, :password_confirmation)
  end

  def require_admin
    redirect_to admin_error_path unless current_user.admin?
  end
end
