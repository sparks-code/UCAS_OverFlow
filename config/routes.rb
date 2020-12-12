Rails.application.routes.default_url_options[:host] = "127.0.0.1:3000"

Rails.application.routes.draw do
  get 'video_replys/new'
  get 'video_replys/edit'
  get 'account_activations/edit'
  get 'static_pages/home'
  get 'sessions/new'
  
  resources :resource_blogs
  resources :text_blogs
  resources :video_blogs
  resources :users
  
  get '/activate', to: 'account_activations#activate_page'
  get '/activate_account', to: 'account_activations#activate_account'

  get '/activate_new', to: 'account_activations#activate_new_page'
  get '/activate_new_account', to: 'account_activations#activate_new_account'

  get '/activate_login', to: 'account_activations#activate_login_page'

  get '/login', to: 'sessions#new'
  post  '/login', to: 'sessions#create'
  get '/email_login', to: 'sessions#email_login'
  post  '/deal_email_login', to: 'sessions#deal_email_login'
  get  '/validates_email_login', to: 'sessions#validates_email_login'
  post '/privilege', to: 'users#set_admin'

  root 'users#hello'
  # 主页
  get '/home', to: 'static_pages#home'
end

