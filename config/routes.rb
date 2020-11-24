Rails.application.routes.draw do
  resources :resource_blogs
  resources :text_blogs
  resources :video_blogs
  resources :file_transfers
  resources :users
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
