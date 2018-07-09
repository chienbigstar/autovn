class HelloController < ApplicationController
  before_action :redirect_by_logined

  def index
    @stopped = params[:stopped]
    render :index, layout: false
  end
end
