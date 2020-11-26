Rails.application.routes.draw do
  get 'static_pages/home'
  get 'sessions/new'
  resources :resource_blogs
  resources :text_blogs
  resources :video_blogs
  resources :users
  
  get '/login', to: 'sessions#new'
  post  '/login', to: 'sessions#create'
  post '/privilege', to: 'users#set_admin'

  # 主页
  get '/home', to: 'static_pages#home'
end

