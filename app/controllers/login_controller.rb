class LoginController < ApplicationController
  before_action :redirect_by_logined, only: :create

  def create
    user = User.find_by login_params
    if user
      session[:current_user] = user
      cookies[:token] = user.token
      cookies[:ip] = request.remote_ip
      user.update ip: request.remote_ip
      redirect_to pages_path
    end
  end

  def new
    @user = User.new
  end

  def user
    @user = User.create login_params
  end

  def destroy
    session.delete(:current_user)
    redirect_to root_path
  end

  private
  def login_params
    params.permit :username, :password
  end
end
