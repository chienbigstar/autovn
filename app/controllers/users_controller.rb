class UsersController < ApplicationController
  before_action :redirect_if_no_admin_or_editor

  def index
    if is_admin?
      @users = User.all.order(:id)
    elsif is_editor?
      @users = User.where.not(role: :admin).order(:id)
    else
      redirect_to root_path
    end
  end

  def new
    @user = User.new
  end

  def create
    User.create user_params
    redirect_to users_path
  end

  def edit
    @user = User.find_by id: params[:id]
  end

  def update
    user = User.find_by id: params[:id]
    user.update user_params
    redirect_to users_path
  end

  def destroy
    user = User.find_by id: params[:id]
    user.delete
    redirect_to users_path
  end

  private
  def user_params
    p = params.require(:user).permit :id, :username, :password, :role, :info, :expired if is_admin?
    p = params.require(:user).permit :id, :username, :password, :info, :expired if is_editor?
    p
  end

  def redirect_if_no_admin_or_editor
    check = false
    check = is_admin? || is_editor?
    redirect_to root_path unless check
  end
end
