class BackupsController < ApplicationController
  before_action :already_login?

  def index
    if params[:search]
      @value = params[:value]
      @backups = Backup.where("name like '%#{params[:value]}%'").order :id
    else
      @backups = Backup.all.order :id
    end
  end

  def new
    @backup = Backup.new
  end

  def create
    Backup.create backup_params
    redirect_to backups_path
  end

  def edit
    @backup = Backup.find_by id: params[:id]
    redirect_to backups_path and return unless (is_admin? || @backup.not_code?)
  end

  def update
    backup = Backup.find_by id: params[:id]
    redirect_to backups_path and return unless (is_admin? || backup.not_code?)
    backup.update backup_params
    redirect_to backups_path
  end

  def destroy
    backup = Backup.find_by id: params[:id]
    redirect_to backups_path and return unless (is_admin? || backup.not_code?)
    backup.delete
    redirect_to backups_path
  end

  private
  def backup_params
    p = if is_admin?
      params.require(:backup).permit :id, :name, :description, :coin, :content, :time, :status
    else
      params.require(:backup).permit :id, :name, :description, :coin, :time, :content
    end
    p[:status] = :not_code unless p[:status]
    p
  end

  def redirect_if_no_admin
    redirect_to(backups_path) and return unless is_admin?
  end
end
