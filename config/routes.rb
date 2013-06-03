Myflix::Application.routes.draw do
  get 'ui(/:action)', controller: 'ui'

  match '/home',	to: 'videos#index'

  resources :videos, only: [:show]
  resources :categories, only: [:show]
end
