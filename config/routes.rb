Rails.application.routes.default_url_options[:host] = "127.0.0.1:3000"

Rails.application.routes.draw do
  get 'account_activations/edit'
  get 'static_pages/home'
  get 'sessions/new'
  resources :resource_blogs
  resources :text_blogs
  resources :video_blogs
  resources :users
  resources :account_activations, only: [:edit]
  
  get '/inactivate', to: 'account_activations#inactivate_page'
  get '/activate', to: 'account_activations#activate_page'

  get '/login', to: 'sessions#new'
  post  '/login', to: 'sessions#create'
  post '/privilege', to: 'users#set_admin'

  root 'users#hello'
  # 主页
  get '/home', to: 'static_pages#home'
end

