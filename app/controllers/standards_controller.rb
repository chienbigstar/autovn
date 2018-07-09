class StandardsController < ApplicationController
  before_action :redirect_if_no_admin, except: :index

  def index
    @standards= Standard.all.order(:id).page(params[:page])
  end

  def new
    @standard = Standard.new
  end

  def update
    config = Standard.find_by id: params[:id]
    config.update config_params
    redirect_to edit_standard_path(config)
  end

  def edit

    @standard = Standard.find_by id: params[:id]
  end

  def create
    Standard.create config_params
    redirect_to standards_path
  end

  def destroy
    config = Standard.find_by id: params[:id]
    config.delete
    redirect_to standards_path
  end

  private
  def config_params
    params.require(:standard).permit :id, :key, :value
  end

  def redirect_if_no_admin
    redirect_to standards_path unless is_admin?
  end
end
