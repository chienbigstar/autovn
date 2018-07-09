class TradeController < ApplicationController
  before_action :already_login?
  
  def aibroker
    render :aibroker, layout: false
  end

  def ustrade
  end

  def weltrade
  end
end
