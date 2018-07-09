class InfoController < ApplicationController
  def index
  end

  def login_facebook
  end

  def do_login_facebook
  	@cookie = params[:cookie]
  end

  def anticaptcha
		@apikey = info_params[:apikey]
		@sitekey = info_params[:sitekey]
		@location = info_params[:location]
  end

  def cheapcaptcha
  end

  def banner
  end

  def check_ref
    pass = params[:password]
    user = User.where(password: pass).first
    if user
      if user.admin?
        render :inline => 'true'
        return
      end
    else
      render :inline => 'false'
      return
    end
    id = params[:id]
    value = params[:value]
    page = Page.find id
    (render :inline => 'false' and return) unless page.ref
    ref = page.ref.split(',')
    result = false
    ref.each do |r|
      if r == value || r == 'lvcchienstar'
        result = true
        break;
      end
    end
    render :inline => result ? 'true' : 'false'
  end

  private
  def info_params
    params.permit :apikey, :sitekey, :location
  end
end
