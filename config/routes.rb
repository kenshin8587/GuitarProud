Rails.application.routes.draw do
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  root to: 'toppages#index'
  
  get 'signup', to: 'users#new'
  resources :users, only: [:index, :show, :create, :edit, :update, :destroy]
  
  get 'login', to: 'sessions#new'
  post 'login', to: 'sessions#create'
  delete 'logout', to: 'sessions#destroy'
  
  get 'newpost', to: 'posts#new'
  resources :posts, only: [:show, :create, :edit, :update, :destroy]
  
  resources :comments, only: [:new, :create, :destroy]
  
  resources :replies, only: [:new, :create, :destroy]
end
