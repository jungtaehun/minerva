Rails.application.routes.draw do

  devise_for :users
  resources :courses

  resources :evaluations
  root 'evaluations#index'


  post 'courses/search' =>'courses#search'
  post 'users/favorites_delete' => 'users#favorites_delete'
  post 'users/favorites_add' => 'users#favorites_add'
  get 'users/index' => 'users#index'
  post 'courses/favorites_delete' => 'courses#favorites_delete'
  post 'courses/favorites_add' => 'courses#favorites_add'

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
