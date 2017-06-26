Rails.application.routes.draw do
  resources :users
  resources :courses
  resources :sessions
  get 'logout', to: 'sessions#destroy', as: 'logout'
  resources :evaluations
  root 'evaluations#index'

  post 'users/favorites_delete'
  post 'users/favorites_add'


  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
