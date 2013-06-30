Myflix::Application.routes.draw do
  root	to: 'pages#front'

  resources :videos, only: [:show] do
  	collection do
  		post :search, to: 'videos#search'
  	end
    resources :reviews, only: [:create]
  end

  resources :categories,    only: [:show]
  resources :users,         only: [:show, :create]
  resources :sessions,      only: [:create]
  resources :queue_items,   only: [:create, :destroy]
  resources :relationships, only: [:destroy]

  post 'update_queue', to: 'queue_items#update_queue'

  get 'home',     to: 'videos#index'
  get 'register', to: 'users#new'
  get 'sign_in',  to: 'sessions#new'
  get 'sign_out', to: 'sessions#destroy'
  get 'my_queue', to: 'queue_items#index'
  get 'people',   to: 'relationships#index'

  get 'ui(/:action)', controller: 'ui'

end
