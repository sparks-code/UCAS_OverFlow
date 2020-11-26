Rails.application.routes.default_url_options[:host] = "127.0.0.1:3000"

Rails.application.routes.draw do
  get 'account_activations/edit'
  get 'sessions/new'
  resources :resource_blogs
  resources :text_blogs
  resources :video_blogs
  resources :users
  
  get '/activate', to: 'account_activations#activate_page'
  get '/activate_account', to: 'account_activations#activate_account'

  get '/activate_new', to: 'account_activations#activate_new_page'
  get '/activate_new_account', to: 'account_activations#activate_new_account'

  get '/login', to: 'sessions#new'
  post  '/login', to: 'sessions#create'
  post '/privilege', to: 'users#set_admin'

  root 'users#hello'
end

