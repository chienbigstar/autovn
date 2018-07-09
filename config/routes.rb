Rails.application.routes.draw do
  # mount ActionCable.server => '/cable'
  resources :groups

  get 'trade/aibroker'
  get 'trade/ustrade'
  get 'trade/weltrade'

  get 'tools/index'
  get 'tools/page_factory'

  get 'info/index'
  get 'info/login_facebook'
  get 'info/do_login_facebook'
  get 'info/anticaptcha'
  get 'info/cheapcaptcha'
  get 'info/banner'
  get 'info/check_ref'

  get 'requests/new'
  get 'requests/update'
  get 'requests/report'
  get 'requests/data'
  get 'requests/add_data'
  get 'requests/page'
  get 'requests/add_data_account'
  get 'requests/info_flamzy_account'
  get 'requests/info_2flamzy_account'
  get 'requests/info_skylom_account'
  get 'requests/info_baymack_account'
  
  resources :slots
  resources :backups
  resources :pages do
    collection do
      get :apply
      get :trade
      post :do_trade
    end
  end
  resources :accounts do
    collection do
      get :copy
    end
  end
  resources :standards
  resources :users

  root 'hello#index'
  get 'dashboard/index'

  post 'login/create'
  # post 'login/user'
  delete 'login/destroy'
  # get 'login/new'

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
