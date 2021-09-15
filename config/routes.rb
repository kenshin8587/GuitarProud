Rails.application.routes.draw do
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  root to: 'toppages#index'
  
  get 'signup', to: 'users#new'
  resources :users, only: [:index, :show, :create, :edit, :update, :destroy] do
    collection do
      get :followings
      get :followers
      get :matches
    end
  end
  
  get 'login', to: 'sessions#new'
  post 'login', to: 'sessions#create'
  delete 'logout', to: 'sessions#destroy'
  
  get 'newpost', to: 'posts#new'
  resources :posts, only: [:show, :create, :edit, :update, :destroy]
  
  resources :comments, only: [:create, :destroy]
  
  resources :replies, only: [:show, :create, :destroy]

  resources :relationships, only: [:create, :destroy]

  resources :messages, only: [:create]

  resources :rooms, only: [:create, :show]

end
