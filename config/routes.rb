Rails.application.routes.draw do
  get 'sessions/new'
  resources :resource_blogs
  resources :text_blogs
  resources :video_blogs
  resources :file_transfers
  resources :users
  
  get '/login', to: 'sessions#new'
  post  '/login', to: 'sessions#create'
  post '/privilege', to: 'users#set_admin'
end

