Rails.application.routes.draw do
  resources :users, only: [:new, :create, :show]
  resources :likes, only: [:create, :destroy]
  root to: 'users#new'
end
