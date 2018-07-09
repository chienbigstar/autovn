module ApplicationHelper
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

  def current_user_groups
    Group.where(user_id: session[:current_user]['id'])
  end
end
