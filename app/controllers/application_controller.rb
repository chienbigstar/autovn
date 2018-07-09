class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception

  def redirect_by_logined
    redirect_to pages_path if login?
  end

  def redirect_by_admin
    redirect_to pages_path if is_admin?
  end

  def already_login?
    redirect_to root_path unless login?
  end

  def login?
    return true if @login
    current_user = session[:current_user]
    return false unless current_user
    @login = true
  end

  def is_admin?
    return true if @is_admin
    return false unless login?
    user = User.find_by_id session[:current_user]['id']
    @is_admin = user.admin?
  end

  def is_editor?
    return @is_editor if @is_editor
    return false unless login?
    user = User.find_by_id session[:current_user]['id']
    @is_editor = user.editor?
  end

  def current_user_id
    login? ? session[:current_user]['id'] : nil
  end
end
