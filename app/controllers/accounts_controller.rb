class AccountsController < ApplicationController
  before_action :already_login?
  
  def index
    if params[:update_all]
      redirect_to(accounts_path) and return unless params[:ids]
      params[:ids].each do |i|
        account = Account.find i
        if account.user_id == session[:current_user]['id']
          account.update "#{params[:type]}": params[:value]
        end
      end
      redirect_to accounts_path
    elsif params[:order]
      @accounts = Account.where(user_id: session['current_user']['id']).includes(:group)
                      .order("#{params['type']}": params[:value]).page(params[:page])
    elsif params[:only]
      if params[:type] == 'group'
        if params[:value] == 'all'
          @accounts = Account.where(user_id: session['current_user']['id']).includes(:group)
                          .order(:id).page(params[:page])
        else
          @accounts = Account.where(user_id: session['current_user']['id']).where(group_id: params[:value]).includes(:group)
                        .order(:id).page(params[:page])
        end
      else
        @accounts = Account.where(user_id: session['current_user']['id']).includes(:group)
                        .order(:id).page(params[:page])
      end
    else
      @accounts = Account.where(user_id: session['current_user']['id']).includes(:group)
                      .order(:id).page(params[:page])
    end
  end

  def new
    @account = Account.new
  end

  def create
    account = Account.create account_params.merge({user_id: session['current_user']['id']})
    flash[:danger] = "Lỗi trùng ip hoặc không phù hợp" unless account.id
    redirect_to accounts_path
  end

  def edit
    @account = Account.find_by id: params[:id]
  end

  def update
    account = Account.find_by id: params[:id]
    if account.user_id != session[:current_user]['id']
      flash['danger'] = "Đã xảy ra lỗi"
      redirect_to accounts_path
      return
    end
    flash[:danger] = "Lỗi trùng ip hoặc không phù hợp" unless account.update account_params
    redirect_to edit_account_path(account)
  end

  def destroy
    account = Account.find_by id: params[:id]
    account.delete
    redirect_to accounts_path
  end

  def copy
    acc = Account.find params[:id]
    acc.id = nil
    @account = Account.new
    @account.assign_attributes acc.attributes
    render :new
  end

  private
  def account_params
    params.require(:account).permit :id, :litecoin, :ethereum, :bitcoin_cash, :bitcore, :blackcoin, :group_id,
      :dashcoin, :peercoin, :primecoin, :anticaptcha_api_key, :_2captcha_api_key, :potcoin, :kb3coin, :info, :info2,
     :ip, :email, :username, :password, :cheapcaptcha_api_key, :bitcoin, :dogecoin, :list, :status
  end
end
