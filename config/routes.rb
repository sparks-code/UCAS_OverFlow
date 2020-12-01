Rails.application.routes.draw do
  get 'sessions/new'
  resources :resource_blogs
  resources :text_blogs
  resources :video_blogs
  resources :users
  
  get '/login', to: 'sessions#new'
  post  '/login', to: 'sessions#create'
  post '/privilege', to: 'users#set_admin'

  post  '/video_blogs/:id/reply', to: 'video_blogs#deal_reply', as: "video_replys"
  get '/video_blogs/tags/:id', to: 'video_blogs#show_tag', as: "show_tag"
end

