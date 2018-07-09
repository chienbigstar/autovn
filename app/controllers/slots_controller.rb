class SlotsController < ApplicationController
  before_action :redirect_if_no_admin, except: :index

  def index
    @slots= Slot.all.order :id
  end

  def new
    @slot = Slot.new
  end

  def update
    config = Slot.find_by id: params[:id]
    config.update config_params
    redirect_to slots_path
  end

  def edit

    @slot = Slot.find_by id: params[:id]
  end

  def create
    Slot.create config_params
    redirect_to slots_path
  end

  def destroy
    config = Slot.find_by id: params[:id]
    config.delete
    redirect_to slots_path
  end

  private
  def config_params
    params.require(:slot).permit :id, :key, :value
  end

  def redirect_if_no_admin
    redirect_to slots_path unless is_admin?
  end
end
